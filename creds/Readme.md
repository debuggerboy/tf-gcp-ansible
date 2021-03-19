# Create SSH Key pair

Navigate to this directory `creds/` :

Issue below command:

```
ssh-keygen -t rsa -b 2048 -C "ansible-key" -f ansible-ci
```

This should create two files:

```
ansible-ci
ansible-ci.pub
```

Rename `ansible-ci` to `ansible-ci.key`

```
mv ansible-ci ansible-ci.key
```

Then, issue:

```
cat ~/.ssh/id_rsa.pub >> auth_keys.pub
cat creds/ansible-ci.pub >> auth_keys.pub
```

Then issue:

```
chmod 600 ansible-ci ansible-ci.pub creds/auth_keys.pub
```

The SSH key file generation is completed.
