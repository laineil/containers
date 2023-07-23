- Admins

| Fcn                         | ID                         | PWD        |
| :-------------------------- | :------------------------- | :--------- |
| Frontend (**config**) Admin | cn=admin,cn=config         | Config@123 |
| Backend (**mdb**) Admin     | cn=admin,dc=example,dc=org | Admin@123  |

- Users (ou=users)

| Fcn              | ID                                       | PWD     |
| :--------------- | :--------------------------------------- | :------ |
| Service Accounts | uid=svc01-02,ou=users,dc=example,dc=org  | Svc@123 |
| General Users    | uid=user01-10,ou=users,dc=example,dc=org | demopw  |

- Groups (ou=groups)

| Fcn                            | Goup                                    | User      |
| :----------------------------- | :-------------------------------------- | --------- |
| Service Groups (groupOfNames)  | cn=svcgp,ou=groups,dc=example,dc=org    | svc01-02  |
| General Groups 01 (posixGroup) | gid=group01,ou=groups,dc=example,dc=org | user01-02 |
| General Groups 02 (posixGroup) | gid=group02,ou=groups,dc=example,dc=org | user03-04 |
| General Groups 03 (posixGroup) | gid=group03,ou=groups,dc=example,dc=org | user05-06 |

- Departments (ou=departments)

| Fcn             | Departments                                              | User      |
| :-------------- | :------------------------------------------------------- | --------- |
| IT Managers     | cn=itmanagers,ou=it,ou=departments,dc=example,dc=org     | user01-02 |
| IT Employees    | cn=itemployees,ou=it,ou=departments,dc=example,dc=org    | user03-04 |
| HR Managers     | cn=hrmanagers,ou=hr,ou=departments,dc=example,dc=org     | user05    |
| HR Employees    | cn=hremployees,ou=hr,ou=departments,dc=example,dc=org    | user06-07 |
| Sales Managers  | cn=salesmanagers,ou=hr,ou=departments,dc=example,dc=org  | user08    |
| Sales Employees | cn=salesemployees,ou=hr,ou=departments,dc=example,dc=org | user09-10 |

- Example Directory Tree

```txt
dc=example,dc=org
├── cn=admin,dc=example,dc=org
├── ou=pwpolicies
│   ├── cn=default,ou=pwpolicies,dc=example,dc=org
│   └── cn=svc,ou=pwpolicies,dc=example,dc=org
├── ou=users
│   ├── uid=svc01,ou=users,dc=example,dc=org
│   ├── uid=svc02,ou=users,dc=example,dc=org
│   ├── uid=user01,ou=users,dc=example,dc=org
│   ├── uid=user02,ou=users,dc=example,dc=org
│   ├── uid=user03,ou=users,dc=example,dc=org
│   ├── uid=user04,ou=users,dc=example,dc=org
│   ├── uid=user05,ou=users,dc=example,dc=org
│   ├── uid=user06,ou=users,dc=example,dc=org
│   ├── uid=user07,ou=users,dc=example,dc=org
│   ├── uid=user08,ou=users,dc=example,dc=org
│   ├── uid=user09,ou=users,dc=example,dc=org
│   └── uid=user10,ou=users,dc=example,dc=org
├── ou=groups
│   ├── cn=services,ou=groups,dc=example,dc=org
│   │   ├── member=svc01,ou=users,dc=example,dc=org
│   │   └── member=svc02,ou=users,dc=example,dc=org
│   ├── cn=admins,ou=groups,dc=example,dc=org
│   │   ├── member=user01,ou=users,dc=example,dc=org
│   │   └── member=user02,ou=users,dc=example,dc=org
│   ├── cn=developers,ou=groups,dc=example,dc=org
│   │   ├── member=user03,ou=users,dc=example,dc=org
│   │   └── member=user04,ou=users,dc=example,dc=org
│   ├── cn=managers,ou=groups,dc=example,dc=org
│   │   ├── member=user01,ou=users,dc=example,dc=org
│   │   ├── member=user02,ou=users,dc=example,dc=org
│   │   ├── member=user05,ou=users,dc=example,dc=org
│   │   └── member=user08,ou=users,dc=example,dc=org
│   └── cn=employees,ou=groups,dc=example,dc=org
│       ├── member=user03,ou=users,dc=example,dc=org
│       ├── member=user04,ou=users,dc=example,dc=org
│       ├── member=user06,ou=users,dc=example,dc=org
│       ├── member=user07,ou=users,dc=example,dc=org
│       ├── member=user09,ou=users,dc=example,dc=org
│       └── member=user10,ou=users,dc=example,dc=org
└── ou=departments
    ├── ou=it
    │   ├── cn=itmanagers,ou=it,ou=departments,dc=example,dc=org
    │   │   ├── member=user01,ou=users,dc=example,dc=org
    │   │   └── member=user02,ou=users,dc=example,dc=org
    │   ├── cn=itemployees,ou=it,ou=departments,dc=example,dc=org
    │   │   ├── member=user03,ou=users,dc=example,dc=org
    │   │   └── member=user04,ou=users,dc=example,dc=org
    ├── ou=hr
    │   ├── cn=hrmanagers,ou=hr,ou=departments,dc=example,dc=org
    │   │   └── member=user05,ou=users,dc=example,dc=org
    │   ├── cn=hremployees,ou=hr,ou=departments,dc=example,dc=org
    │   │   ├── member=user06,ou=users,dc=example,dc=org
    │   │   └── member=user07,ou=users,dc=example,dc=org
    └── ou=sales
        ├── cn=salesmanagers,ou=sales,ou=departments,dc=example,dc=org
        │   └── member=user08,ou=users,dc=example,dc=org
        └── cn=salesemployees,ou=sales,ou=departments,dc=example,dc=org
            ├── member=user09,ou=users,dc=example,dc=org
            └── member=user10,ou=users,dc=example,dc=org
```