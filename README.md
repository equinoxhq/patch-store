# Lucem's Patch Store
This repository contains metadata for all custom community-made patches for Roblox that can be used via [Lucem](https://github.com/equinoxhq/lucem)

# Adding a patch
## creating it
We are working on documentation on the `lpat.json` format. For now, you can check Lucem's builtin patches in the source tree to understand how to make one.

## hosting it
Firstly, create a Git repository on one of the following platforms:
- Github
- Gitlab

(we restrict the URLs very strictly to prevent abuse)

## submitting it to the index
The steps to submit a patch to this index are:
* Fork this repository
* Open `index.json` in your text editor or IDE of choice
* Add the full URL to your patch's source in the JSON array.
* Optionally, run `neo run validator` to validate your changes.

The URL cannot:
- Point to a hostname other than Github or Gitlab.
- Have a non-HTTPS scheme.
- Be a malformed URL (as per the WHATWG spec - the validator and Lucem use [nim-url](https://github.com/xTrayambak/url) for dealing with the URLs!)

## make a merge request
Make a PR and we'll review it and merge it as soon as possible. We will try to audit it a little to ensure it isn't something malicious, but we cannot guarantee anything. (More on this later)

# safety
Lucem, by design, is a sandboxed application. It uses Flatpak and the patch executor is fairly defensive, so doing anything malicious with `lpat` files should be difficult. We'll try to audit patches here, but we cannot assure anything. **Any user caught submitting malicious or intentionally borked patches will be permanently banned from ever submitting patches.**
