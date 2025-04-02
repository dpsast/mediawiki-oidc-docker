# Mediawiki docker image with oidc support

## Upgrade method

1. Replace `FROM mediawiki:1.43.0` with new version.
2. Replace `PLUGGABLE_AUTH_VERSION` and `OPENID_CONNECT_VERSION` with new version. You can check [this site](https://www.mediawiki.org/wiki/Extension:OpenID_Connect) to get the version. (Check the download file name)
3. Tag the branch with `v.mediawiki_vision(like 1.43).small_version`
