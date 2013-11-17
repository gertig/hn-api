# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
HnApi::Application.config.secret_key_base = ENV["SECRET_TOKEN"] || "d33e328892d9131f18e8bcf540e637235a5bca4894ad276628e2dfffdf4be43f373a104e1174d5e76e779868d75bae56016c119aae8bbbe4c7a478e222abfe23"
