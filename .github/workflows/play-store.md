# Android CI/CD Setup for Play Store

A simple, step-by-step guide to automate Android internal testing releases using GitHub Actions.

---

## 🚀 1. Prerequisites

Before starting, ensure you have:

- [ ] A **Google Play Console** developer account.
- [ ] An **App created** in Play Console with your package name (e.g., `com.example.app`).

---

##  2. Grant Access in Play Console

1.  Copy this email (use the 📋 copy button):
    ```
    github-actions@github-action-451913.iam.gserviceaccount.com
    ```

2.  Go to **Google Play Console** > **Users and permissions**.    
3.  Click **Invite new users**.
4.  Paste the email.
5. Enable the following permissions:

- [x] Release to production, exclude devices, and use Play App Signing
- [x] Release apps to testing tracks
- [x] Manage testing tracks and edit tester list
- [x] Manage store presence
- [x] Manage policy declarations
- [x] Manage deep links

6.  Click **Invite user**.


----


## 🔑 3. Add Secrets to GitHub

Run this command to generate the `KEYSTORE_BASE64` value (use the 📋 copy button in the top-right of this code block):

```bash
base64 -i android/app/upload-keystore.jks > .github/workflows/keystore_base64.txt
```

Go to your Repo: **Settings > Secrets and variables > Actions > New repository secret**.

| Secret Name | Value to Paste |
| :--- | :--- |
| `KEYSTORE_BASE64` | The output of the command above. |
| `STORE_PASSWORD` | Password for your keystore file. |
| `KEY_PASSWORD` | Password for your key alias (usually same as store). |
| `KEY_ALIAS` | Alias name (e.g., `upload`, `key0`). |
| `PLAY_STORE_JSON` | Content of your Service Account JSON file. |


<https://docs.google.com/document/d/1F3EU1D0uUV17cEpjH12iCZjBJSmVNMZ57KEHgofAFYI/edit?tab=t.0>
