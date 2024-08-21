# Design of Lab 4's Login System

## Mechanisms for Securing

To secure the login system, we gave root the highest privledges. Note that it is a slight security concern if any malicious user were to find out that the password to root is 'admin'. Root is the only user who can peek at the secrets file containing all the usernames and password hashes, including all other users on the file system. No other users have the privledge to do so. 

When we create a user, we take in the inputted username and password. Mechanisms for securing the password include first salting by appending a character at the end of the password, then hashing the entire thing with sha256. It is a security concern if a malicious user were to know the salt character, specifically a 'c'. If a user is trying to login to a previously created account, the account is secured by asking for a password, which is salted, hashed, then compared to the hash that is stored in the secrets file. If the hashes don't match, the prompter is unable to login to the intended account.

## Files Created

The only file created was the secrets file containing all the usernames and hashed + salted passwords. 
