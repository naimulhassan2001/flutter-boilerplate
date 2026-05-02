# Sign-In Feature Specification

Implementation-ready document for the Sign-In (Authentication) feature in the Flutter boilerplate. Aligned with the existing Feature-First Clean Architecture refactor under `lib/features/auth/sign_in/`.

---

## 1. Purpose & Scope

### Purpose
Allow returning users to authenticate against the backend, persist a session locally, and gain access to authenticated routes (Profile, Messages, Settings, etc.).

### In Scope
- Email + password authentication.
- Session persistence (access token, refresh token, user model) via `SharedPreferences`.
- Form-level validation, loading state, error feedback.
- Navigation to authenticated home (`AppRoutes.profile`) on success.
- Navigation hooks to **Forgot Password** and **Sign Up** flows.
- Auto-injection of `Authorization` header for subsequent API calls (via `auth_interceptor.dart`).

### Out of Scope (today — listed for roadmap)
- Social login (Google / Apple / Facebook).
- OTP-based passwordless sign-in.
- MFA / 2FA.
- Biometric unlock (Face ID / Touch ID).
- Server-side rate limiting & account lockout (these are backend concerns; client only reacts to status codes).

---

## 2. Authentication Methods

| Method | Status | Notes |
|---|---|---|
| Email + Password | **Implemented** | `POST users/sign-in` with `{email, password}` body |
| Forgot Password (email OTP reset) | Implemented (separate feature) | Lives in `features/auth/forgot password/` |
| Google Sign-In | Planned | Add `google_sign_in` package, new use case `SignInWithGoogleUseCase`, new remote method |
| Apple Sign-In | Planned | iOS-only; `sign_in_with_apple` package |
| OTP / Magic Link | Planned | New endpoint pair: `POST /auth/otp/request`, `POST /auth/otp/verify` |
| MFA (TOTP) | Planned | Two-step: sign-in returns `mfaRequired: true` + `mfaToken`; second call submits TOTP |
| Biometric local unlock | Planned | `local_auth` to gate app open when token already exists |

**Extension pattern:** add a new use case (e.g. `SignInWithGoogleUseCase`) that depends on the same `SignInRepository` interface — extended with method `signInWithGoogle(idToken)`. Controllers stay thin, presentation only changes by adding new buttons.

---

## 3. User Flows

### 3.1 Happy path — Email + Password
1. User opens `SignInScreen`.
2. Enters email and password; both fields validated on form submit (`AppValidation.email`, `AppValidation.password`).
3. Taps **Sign In** → `SignInController.submit()`:
   1. Sets `isLoading = true`, calls `update()`.
   2. Invokes `SignInUseCase(email, password)`.
   3. Use case → `SignInRepository.signIn()` → `SignInRemoteDataSource.signIn()` → `POST /users/sign-in`.
4. On HTTP 200/201:
   - Repository persists `accessToken`, `refreshToken`, and user JSON via `LocalStorage`.
   - Returns `AuthSession` to controller.
5. Controller clears text fields and calls `Get.offAllNamed(AppRoutes.profile)`.

### 3.2 Failure paths

| Scenario | Trigger | Response |
|---|---|---|
| Invalid credentials | API 401 | `SignInException` thrown; `AppSnackbar.error` shows backend message |
| Account not verified | API 403 with code | Snackbar; optionally redirect to `verifyEmail` route |
| Validation failure | Empty / malformed input | Form validators block submit, inline error message under field |
| Network error | Dio `DioException` (no internet, timeout) | Caught in `catch (e)`; snackbar `Error: <message>` |
| Server error | API 5xx | `SignInException(message, 5xx)`; user sees `AppString.startServer` for 502 |
| Concurrent submit | Double-tap before response | Guarded by `if (isLoading) return;` |

### 3.3 Edge cases
- **Token expired between sessions:** handled by `auth_interceptor.dart` — refresh-token round trip; if that fails, `LocalStorage.logout()` redirects to `signIn`.
- **Empty response body:** `AuthSessionModel.fromJson` defensively defaults missing fields to `''` / `{}`. Caller still proceeds — but a follow-up should treat empty access token as a server contract violation and surface an error.
- **Backgrounded during request:** GetX controller survives via `fenix: true`; on resume, the in-flight Future completes and updates state.
- **User signs in on second device:** server may invalidate prior refresh token; the original device hits 401 on next call → interceptor logs out.

---

## 4. Sub-Features

| Sub-feature | Status | Location |
|---|---|---|
| Email validation | Done | `utils/helpers/validation.dart` → `AppValidation.email` |
| Password validation (min length, complexity) | Done | `AppValidation.password` |
| Show/hide password toggle | Done | `CommonTextField(isPassword: true)` |
| Forgot password link | Done | Navigates to `AppRoutes.forgotPassword` |
| Sign up link | Done | `DoNotHaveAccount` → `AppRoutes.signUp` |
| "Remember me" | **Planned** | Today, session always persists. Add a checkbox; if unchecked, store tokens in-memory only (clear on app close) |
| Account lock after N failed attempts | **Backend** | Client only reacts to backend `423 Locked` |
| Loading indicator | Done | `CommonButton(isLoading: ...)` |
| Auto-fill / password manager support | Native | Inherits from Flutter `TextField` autofill hints — **TODO**: add `autofillHints: [AutofillHints.email, AutofillHints.password]` |
| Biometric quick re-login | Planned | New `BiometricSignInUseCase` reusing stored refresh token |

---

## 5. Validation Rules

Defined in `utils/helpers/validation.dart`. Client-side; server is authoritative.

### Email
- Required, non-empty after trim.
- Matches RFC-5322-lite regex.
- Error: *"Please enter a valid email"*.

### Password
- Required, non-empty.
- Min 8 chars.
- (Recommended addition) at least one uppercase, one digit, one special.
- Error: *"Password must be at least 8 characters"*.

### Form
- Submit button calls `_formKey.currentState!.validate()` before invoking the use case. Use case is never called with invalid input.

---

## 6. Error Handling

### Layered strategy
| Layer | Handles | Translates to |
|---|---|---|
| Data source | HTTP status, network exceptions | `SignInException(message, statusCode)` for non-2xx; lets `DioException` bubble up otherwise |
| Repository | (Pass-through; future: caching/fallback) | — |
| Use case | (Pass-through) | — |
| Controller | All exceptions | `AppSnackbar.error(...)`. Resets `isLoading`. |

### Status-code map (client-side reaction)
| Status | UX |
|---|---|
| 200/201 | Persist session, navigate to profile |
| 400 | "Invalid request" snackbar |
| 401 | "Invalid email or password" |
| 403 | "Account not verified" + offer resend |
| 423 | "Account locked. Try again in N minutes." |
| 429 | "Too many attempts. Please wait." |
| 5xx | Generic "Service unavailable" / `AppString.startServer` for 502 |

---

## 7. Security Best Practices

### Implemented
- Passwords sent over HTTPS only (enforce via `ApiEndPoint.baseUrl` — **TODO**: switch from `http://` to `https://`).
- Tokens stored via `SharedPreferences` (acceptable for non-PII tokens but **see "Hardening" below**).
- Auth header injection centralized in `auth_interceptor.dart`.
- Refresh token rotation supported by interceptor.

### Hardening (recommended)
1. **Switch token storage to `flutter_secure_storage`** — Keychain on iOS, Keystore on Android. `SharedPreferences` is plain text on disk.
2. **HTTPS everywhere** — `ApiEndPoint.baseUrl` currently uses `http://`. Move to `https://` and pin the cert (`dio` + `BadCertificateCallback`).
3. **Never log tokens or passwords.** Audit `app_log.dart` calls; add a redactor for known sensitive keys.
4. **Password hashing is server-side only.** Client sends raw password over TLS. Bcrypt/Argon2id at rest on the server.
5. **Rate limiting + lockout: server-side.** Client honours `429` + `423` and surfaces clear UX.
6. **Refresh token rotation** — every refresh issues a new refresh token; revoke prior. Already supported by interceptor; verify backend enforces rotation.
7. **Short access-token TTL** (15 min) + long refresh-token TTL (30 days) with revocation on password change.
8. **Clear sensitive form fields on backgrounding** — use `WidgetsBindingObserver` to clear password on `AppLifecycleState.paused`.
9. **Disable autocorrect / spell-check on password field** — already done by `obscureText`.

---

## 8. API Design

Base URL: `ApiEndPoint.baseUrl` → `http://103.145.138.74:3000/api/v1` (move to HTTPS).

### 8.1 `POST /users/sign-in`

**Request**
```http
POST /users/sign-in HTTP/1.1
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "P@ssw0rd!"
}
```

**Response — 200 OK**
```json
{
  "success": true,
  "message": "Sign-in successful",
  "data": {
    "accessToken": "eyJhbGciOi...",
    "refreshToken": "eyJhbGciOi...",
    "user": {
      "id": "u_01HXYZ...",
      "email": "user@example.com",
      "name": "Jane Doe",
      "avatarUrl": "https://.../avatar.png",
      "emailVerifiedAt": "2026-04-12T08:34:11Z"
    }
  }
}
```

**Response — 401 Unauthorized**
```json
{
  "success": false,
  "message": "Invalid email or password"
}
```

**Response — 403 Forbidden (unverified)**
```json
{
  "success": false,
  "message": "Email not verified",
  "code": "EMAIL_NOT_VERIFIED"
}
```

**Response — 423 Locked**
```json
{
  "success": false,
  "message": "Account temporarily locked",
  "data": { "retryAfterSeconds": 600 }
}
```

### 8.2 `POST /users/refresh-token` (used by interceptor)

**Request**
```json
{ "refreshToken": "eyJhbGciOi..." }
```

**Response — 200**
```json
{
  "success": true,
  "data": { "accessToken": "...", "refreshToken": "..." }
}
```

### 8.3 Status-code conventions

| Code | Meaning |
|---|---|
| 200 | Success |
| 400 | Malformed payload |
| 401 | Invalid credentials / expired token |
| 403 | Forbidden (unverified, suspended) |
| 422 | Validation error (per-field) |
| 423 | Account locked |
| 429 | Rate limited |
| 5xx | Server failure |

---

## 9. Architecture (Feature-First Clean Architecture)

### Folder structure
```
lib/features/auth/sign_in/
├── domain/
│   ├── entities/
│   │   └── auth_session.dart            # Pure Dart entity
│   ├── repositories/
│   │   └── sign_in_repository.dart      # Abstract contract
│   └── usecases/
│       └── sign_in_usecase.dart         # Single-verb use case
├── data/
│   ├── datasources/
│   │   └── sign_in_remote_data_source.dart  # Talks to ApiClient
│   ├── models/
│   │   └── auth_session_model.dart      # Extends entity, JSON parsing
│   └── repositories/
│       └── sign_in_repository_impl.dart # Implements domain contract; persists session
└── presentation/
    ├── controller/
    │   └── sign_in_controller.dart      # GetX controller, UI state only
    ├── screen/
    │   └── sign_in_screen.dart          # Stateless widget + GetBuilder
    └── widgets/
        └── do_not_have_account.dart     # Sign-up CTA
```

### Layer responsibilities
| Layer | Knows about | Knows nothing about |
|---|---|---|
| `domain/` | Pure Dart, dart core | Flutter, Dio, GetX, SharedPreferences |
| `data/` | Domain, Dio, SharedPreferences | Flutter widgets, GetX |
| `presentation/` | Domain (use cases), Flutter, GetX | Dio, SharedPreferences, JSON |

### Dependency graph (run-time)
```
SignInScreen
   │ (GetBuilder)
   ▼
SignInController  ──► SignInUseCase  ──► SignInRepository (abstract)
                                              │
                                              ▼
                                    SignInRepositoryImpl
                                       │             │
                                       ▼             ▼
                          SignInRemoteDataSource  LocalStorage
                                       │
                                       ▼
                                   ApiClient  (Dio + interceptors)
```

### DI wiring (`config/dependency/dependency_injection.dart`)
```dart
Get.lazyPut<ApiClient>(() => DioApiClient(), fenix: true);
Get.lazyPut<SignInRemoteDataSource>(
  () => SignInRemoteDataSourceImpl(Get.find<ApiClient>()), fenix: true);
Get.lazyPut<SignInRepository>(
  () => SignInRepositoryImpl(Get.find<SignInRemoteDataSource>()), fenix: true);
Get.lazyPut(() => SignInUseCase(Get.find<SignInRepository>()), fenix: true);
Get.lazyPut(() => SignInController(Get.find<SignInUseCase>()), fenix: true);
```

---

## 10. Database / Storage Schema

### Server-side (canonical)
```sql
CREATE TABLE users (
  id              UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  email           CITEXT       NOT NULL UNIQUE,
  password_hash   TEXT         NOT NULL,        -- argon2id
  name            TEXT,
  avatar_url      TEXT,
  email_verified_at TIMESTAMPTZ,
  failed_attempts INT          NOT NULL DEFAULT 0,
  locked_until    TIMESTAMPTZ,
  created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE refresh_tokens (
  id           UUID        PRIMARY KEY,
  user_id      UUID        NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash   TEXT        NOT NULL,           -- store hash, not raw token
  expires_at   TIMESTAMPTZ NOT NULL,
  revoked_at   TIMESTAMPTZ,
  user_agent   TEXT,
  ip_address   INET,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ON refresh_tokens (user_id);

CREATE TABLE auth_audit_log (
  id          BIGSERIAL    PRIMARY KEY,
  user_id     UUID         REFERENCES users(id),
  event       TEXT         NOT NULL,           -- SIGN_IN_SUCCESS, SIGN_IN_FAIL, LOCKED, ...
  ip_address  INET,
  user_agent  TEXT,
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);
```

### Client-side persistence (`SharedPreferences` keys — `LocalStorageKeys`)
| Key | Type | Purpose |
|---|---|---|
| `token` | String | Access token (Bearer) |
| `refreshToken` | String | Refresh token |
| `user` | String (JSON) | Cached `UserModel` |

**Recommended:** migrate `token` and `refreshToken` to `flutter_secure_storage`; keep `user` in `SharedPreferences` (non-sensitive cache).

---

## 11. Risks & Edge Cases

| Risk | Mitigation |
|---|---|
| Tokens leak via insecure storage | Move to `flutter_secure_storage` |
| Plain-HTTP downgrade / MITM | Force HTTPS + cert pinning |
| Endless retry loop on 401 | Interceptor must short-circuit after one refresh attempt |
| Stale `UserModel` cache after profile edit | Invalidate / re-fetch after profile mutation |
| Clock skew breaks JWT validation | Tolerate ±60s; rely on server to validate |
| Multiple in-flight refreshes during burst | Single-flight refresh promise in interceptor |
| Deep link to authed screen pre-login | Splash routes to `signIn`, preserves intent, restores after success |
| User changes password on other device | Server revokes refresh tokens; client lands at sign-in via interceptor logout |
| Empty / malformed `data` payload | Defensive defaults + treat empty access token as failure |
| Snackbar floods on rapid retries | Debounce or guard via `isLoading` (already in place) |

---

## 12. Testing Strategy

### Unit tests
- **Domain:** `SignInUseCase` — verify it forwards to repo; null/empty inputs.
- **Data:** `AuthSessionModel.fromJson` — happy path, missing fields, wrong types.
- **Data:** `SignInRemoteDataSourceImpl` — mock `ApiClient`; assert correct endpoint, body, exception on non-2xx.
- **Data:** `SignInRepositoryImpl` — mock data source + `LocalStorage`; assert persistence order.
- **Presentation:** `SignInController.submit()` — mock `SignInUseCase`; assert loading toggles, navigation, snackbar on error.

### Widget tests
- `SignInScreen` renders email + password fields, button.
- Validation errors show on empty submit.
- Loading state disables button.

### Integration tests
- End-to-end: launch app → enter creds → mock server returns 200 → land on profile.
- Mock 401 → snackbar shown, stays on screen.
- Mock 423 → lockout message.
- Refresh-token interceptor: simulate expired access token → assert single refresh + retry.

### Security tests
- Static analysis: ensure no `print(token)` / `appLog(password)`.
- Token storage smoke test: confirm secure storage values are not readable from plain SharedPreferences.
- Replay test: reuse a revoked refresh token → expect 401 + forced logout.
- Brute-force simulation against staging: verify backend lockout kicks in.

### Test layout
```
test/
└── features/auth/sign_in/
    ├── domain/sign_in_usecase_test.dart
    ├── data/
    │   ├── auth_session_model_test.dart
    │   ├── sign_in_remote_data_source_test.dart
    │   └── sign_in_repository_impl_test.dart
    └── presentation/sign_in_controller_test.dart
```

---

## 13. Performance & Scalability

### Client
- Lazy-injected dependencies (`Get.lazyPut(... fenix: true)`) — controller and chain instantiated on first navigation, kept alive across rebuilds, recreated after disposal.
- `StatelessWidget` + `GetBuilder` minimizes rebuilds to the form region only.
- Single in-flight guard (`isLoading`) prevents duplicate POSTs.
- Image / asset weight not relevant for this feature.

### Network
- Sign-in is a single round trip; no pagination or caching.
- Use HTTP/2 keep-alive (Dio default).
- Compress request bodies (`Content-Encoding: gzip`) on backend if payloads grow.

### Backend / scalability (informational)
- Stateless JWT access tokens scale horizontally.
- Refresh tokens stored hashed in Postgres; index on `user_id` and `token_hash`.
- Rate-limit `/sign-in` per IP + per email (e.g., 5/min) at the gateway.
- Argon2id with memory cost tuned to ~150ms per attempt — slows brute force without burning user-perceived latency.
- Audit log is append-only; partition by month if volume warrants.

---

## 14. Definition of Done

- [ ] All four layers implemented & wired in DI.
- [ ] HTTPS endpoint + secure storage in place.
- [ ] Validation messages localized (where i18n applies).
- [ ] Unit + widget + at least one integration test green.
- [ ] No tokens / passwords in logs (verified by static check).
- [ ] Snackbar copy reviewed for each status code mapped in §6.
- [ ] Forgot-password and sign-up routes reachable from screen.
- [ ] Refresh-token interceptor verified against expired-token scenario.
- [ ] Manual smoke test on Android + iOS + Web (if web target ships).
