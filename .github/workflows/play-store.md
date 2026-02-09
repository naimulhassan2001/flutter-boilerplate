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


```bash
{
  "type": "service_account",
  "project_id": "github-action-451913",
  "private_key_id": "1c0f10833e32caf34c74e72f27517e1f84560f3b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCrbr04qp/I+kJr\n/Ta3bI1gU3nzZ/fCa7g/rdtC2AYOym+33A/p+t+Cw+NuA+p7hCUOE3Gfm8Cp4cdX\nWH6VFj1pOct7SbxLU4ry91IWaGpqsvtClMnu807A2EyMDIEIH+VZ8tM+LY6KWuek\npK8KDo39LdVfOIEN1DRM7w2nBGq2zWUuj5YGK20TTz636MzHcHdRAJ4BepzZp0M0\n8HM50XIyHhaWagQA3WKE46sd/rqI+aOdQU3dyp+IqEGGFWigCjocKVEgQBqV223S\niHe4c/Wzw6oZOKD+UU7KsNoisq1VqGqZk5NdqxdQnVqfO42JT5ldEuhNitQxYoBJ\nJqKN4Mn9AgMBAAECggEACCp5eXRJMa/YD6BLZa/WSScYyUMjzl9GssPTjKrRGQ3E\nBhBFssnIMUim8fPeTL1l7XZ4JFftNLpkPjEhMHVTfgpqeqgvv6/OT9X/k0EshoIZ\njVmch9UPpIh5Fve2gr5QNLloHg9Z+ZWscI+GpfY9BbkT75n3rcK0rhB6CEFh2uy4\nPYA39f+KB+HtLWxuuX1wOyDomvj+LJtc3vAJsOrUdj3H0pfYMcmLRNKIFeYuxB+G\n9mlm5B7zDdck11LZZHd1HIo/HEKfl03Q3V7obpfbJiV5NUm6bPfcYk6Gq+ajURxP\n4wc2rysbJkNWRX9Hny9IP4wigYxG9Oep3WzyGjuZoQKBgQDeaX/9DrutorWA2qVU\nEN5hbY5qh4MU6RS08Dp/RpZ9iXg5PYSiMnAeu1EzJ8bAtCmH4kW5eLq4NpqVVVfd\nrQ02LYs39FagBKM0Was1RvHklDIZTsbSAeYBXq8aNZoVuUBiIuD+bqtTlDzn+UE4\noqD0GL6X/qTc459FRJuVi/ry3QKBgQDFUlwCU1gLwI8odoW9ex+7RGKpkuNyu7JQ\naWplHv+3f1vewG8619E+wUkU1/ULyS9kNSQGQdqbN2KtPRZLt7s4X+tlf1VOs0zq\nwJN4kRj1Dorfo1AQ+/HS3yuNvrJa0x0kVosULKnrhOa6iiIDL41BIcYSNxfyp9Co\nQxE1i1zxoQKBgDK7c+NgSfUYaThkJ1QeqOsmV1b7ZC4P4JZJOb6wdkFaax77Zlat\nFKAd8C6wAwkPz21ccrUU0dqVMfugRPOetqXGC7yOsne7txKI5aG4dhLCrw7Qxk8+\n+Z0UYPKkiWotIH+CHzpKOjBNXvs3AuaNShOD1W3MOwTbswfU13xsOqjNAoGAHgMY\n24GxspfnLlBYpylC+ki8eO5OifTiejiOZjMA0fgdERRT1q9ctB7R7smqC9Dd1HAA\nurLpfRI/f/n6mimn4Ds2oolrgDzlRg9kXsIy+ZLsrHc6hlrLvTcUeMq4dfgGRrCj\nFr50Wc4tCdJYugNRiMaKSdr3WYEMy4rn4yz/RgECgYBoZe4fSzx0v7SoiSfU8v8I\nwPztPXekPUJHBQ1OhA4pQoKBv5ThwPIxn1IdzoqeS+GLFydZa5QRC3IHwedmMG8K\noKKXHSgm0/TQ6J4HE+A5cTxh6LDqwPsSisVZVofrsuVPl4N1vXPV+/DfNgN2+Bbu\nDm7rm1iZvfqFc4uFSyfr+w==\n-----END PRIVATE KEY-----\n",
  "client_email": "github-actions@github-action-451913.iam.gserviceaccount.com",
  "client_id": "103325203960086756027",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions%40github-action-451913.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}

```