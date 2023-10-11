#! /bin/bash

# Parse args
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"
   export "$KEY"="$VALUE"
done


connstring=postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB

accounts=('jhon@doe' 'marry@doe')
# seed accounts 
for account in ${accounts[@]}
do
psql $connstring <<EOF
   WITH acc 
   AS ( INSERT INTO Accounts (email, password)
        VALUES ('$account', '1234') returning * ) 
    INSERT INTO Profiles (fk_account_id) VALUES ((SELECT id FROM acc));
EOF
done



# Insert institution, faculty and faculty user
psql $connstring <<EOF
    WITH instution AS (
        INSERT INTO institutions (name, fk_account_id)
        VALUES (
            'Çanakkale Onsekiz Mart Üniversitesi', 
            (SELECT id FROM accounts LIMIT 1)
        ) RETURNING *
    ),
    faculty AS (
        INSERT INTO Faculties
            (name, fk_institution_id)
        VALUES (
            'Mühendislik Fakültesi',
            (SELECT id FROM instution)
        ) RETURNING *
    )
    INSERT INTO jk_faculty_users
        (fk_faculty_id, fk_profile_id)
    VALUES (
            (SELECT id FROM faculty),
            (SELECT id FROM profiles LIMIT 1));
EOF

