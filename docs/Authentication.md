# Authentication

## Overview

CalSync integrates with various identity providers using [OmniAuth](https://github.com/omniauth/omniauth) to allow users to sign in and out of the application. The following sections describe how to configure these integrations. CalSync itself is configured through the Rails credential system, which stores secrets in an encrypted format. For more info on Rails credentials, take a look at [this article](https://webcrunch.com/posts/the-complete-guide-to-ruby-on-rails-encrypted-credentials).

In development, CalSync also supports quickly creating developer accounts using OmniAuth's built-in developer strategy. Simply navigate to <http://localhost:3000/auth/developer> to create an account for manual testing.

Currently supported IDPs: [Google](#google), [Microsoft](#microsoft-office-365organizationboth)

## Google

OAuth2 with Google requires two credentials: a client ID and a client secret. These are set in the credentials file under `google_oauth2` as `client_id` and `client_secret`. To get these credentials, you will need to create an application on the [Google Cloud Console](https://console.cloud.google.com/apis/dashboard).

Relevant documentation at [support.google.com](https://support.google.com/cloud/answer/15544987)

### Set up a Google Cloud application

1. Create a new project in the Google Cloud Console
2. Configure your OAuth flow
    * Navigate to "OAuth consent screen" and fill out the form
    * Navigate to "Data Access" and select "Add or remove scopes"
    * Click on the "Google API Library" link and enable the Google Calendar API
    * On the following page, press the "Create Credentials" button and create credentials for the app. Do not select scopes yet
    * Select "Web application" as the application type
    * Add an authorized redirect URI: `http(s)://your-domain.com/auth/google_oauth2/callback`
        * For development/testing, use: `http://localhost:3000/auth/google_oauth2/callback`
    * Click "Create"
    * Copy the client ID shown in the confirmation dialog. Save this secret in Rails credentials
    * Navigate to Credentials > your new client ID
    * Copy the client secret shown. Save this secret in Rails credentials
3. Select scopes
    * Navigate to "Data Access" and select "Add or remove scopes"
    * Select ".../auth/userinfo.name", ".../auth/userinfo.email", "openid", ".../auth/calendar.calendars.readonly", ".../auth/calendar.events.readonly", and ".../auth/calendar.events.owned"
    * Press "Update", then "Save"
4. Launch (or relaunch) your CalSync instance and test it out!

## Microsoft (Office 365/organization/both)

OAuth2 with Microsoft requires two credentials: a client ID and a client secret. These are set in the credentials file under `microsoft_office365` as `client_id` and `client_secret`. To get these credentials, you will need to create an application in the [Microsoft Entra admin center](https://entra.microsoft.com/#home).

Relevant documentation at [learn.microsoft.com](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/add-application-portal-setup-oidc-sso)

### Set up a Microsoft Enterprise App

1. Create an Enterprise App
    * Navigate to "Enterprise Apps" > "All Applications" and click "New Application"
    * Enter a name, then select "Register an application to integrate with Microsoft Entra ID (App you're developing)"
    * Depending on your intended use case, select the correct option under "Supported account types"
        * For the widest compatibility, choose "Accounts in any organizational directory and personal Microsoft accounts". This is the recommended option
    * Add a redirect URI: `http(s)://your-domain.com/auth/microsoft_office365/callback` with platform "Web"
        * For development/testing, use: `http://localhost:3000/auth/microsoft_office365/callback`
    * Click "Register"
2. Configure your OAuth flow
    * Navigate to "App registrations" > "All apps"
    * Select your app
    * In the "API permissions" pane, add these permissions: `offline_access`, `openid`, and `Calendars.ReadWrite.Shared`. `User.Read` should be selected by default
        * These can be found under "Microsoft Graph" > "Delegated permissions" > "OpenId permissions"
3. Set up credentials for your CalSync instance
    * Navigate to "App registrations" > "All apps"
    * Select your app
    * In the "Overview" pane, in the "Essentials" section, click "Add a certificate or secret" then "New client secret"
    * Enter a description and expiration date and confirm
    * Copy the secret, shown in the "Value" column. Save this secret in Rails credentials
        * Do this before closing the dialog as __you will not be able to see the secret again__
    * Navigate back to the "Overview" pane
    * In the "Essentials" section, copy the client ID, labeled "Application (client) ID". Save this secret in Rails credentials
4. Launch (or relaunch) your CalSync instance and test it out!
