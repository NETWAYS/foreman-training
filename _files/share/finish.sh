echo "foreman.localdomain" > /etc/hostname
echo "10.0.0.1 host.localdomain host" >> /etc/hosts
echo "10.0.0.2 foreman.localdomain foreman" >> /etc/hosts

yum install -y openldap-servers openldap-clients

echo 'dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=localdomain
-
replace: olcRootDN
olcRootDN: cn=admin,dc=localdomain
-
add: olcRootPW
olcRootPW: {SSHA}pQjSq3J3wXsHahiaYh6UyQpCTFx4G80s' > start.ldif

echo 'dn: dc=localdomain
dc: localdomain
ou: localdomain
objectClass: dcObject
objectClass: organizationalUnit' > domain.ldif

echo 'dn: ou=users,dc=localdomain
objectClass: organizationalUnit
ou: users
description: Users

dn: cn=administrator,ou=users,dc=localdomain
objectClass: inetOrgPerson
cn: administrator
sn: User
description: Administrator
userPassword: {SSHA}pQjSq3J3wXsHahiaYh6UyQpCTFx4G80s
givenName: Administrator
mail: administrator@localdomain
uid: administrator

dn: cn=viewer,ou=users,dc=localdomain
objectClass: inetOrgPerson
cn: viewer
sn: User
description: Viewer
userPassword: {SSHA}pQjSq3J3wXsHahiaYh6UyQpCTFx4G80s
givenName: Viewer
mail: viewer@localdomain
uid: viewer

dn: cn=selfservice,ou=users,dc=localdomain
objectClass: inetOrgPerson
cn: selfservice
sn: User
description: Selfservice
userPassword: {SSHA}pQjSq3J3wXsHahiaYh6UyQpCTFx4G80s
givenName: Selfservice
mail: selfservice@localdomain
uid: selfservice

dn: ou=groups,dc=localdomain
objectClass: organizationalUnit
ou: groups
description: Groups

dn: cn=admins,ou=groups,dc=localdomain
objectClass: posixGroup
cn: admins
description: Admins
gidNumber: 666
memberUid: administrator' > users.ldif

systemctl start slapd
systemctl enable slapd
ldapadd -Y EXTERNAL -H ldapi:/// -f start.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
ldapadd -x -D "cn=admin,dc=localdomain" -w netways -f domain.ldif
ldapadd -x -D "cn=admin,dc=localdomain" -w netways -f users.ldif

