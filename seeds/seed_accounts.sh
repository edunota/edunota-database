#! /bin/bash


# seed accounts 

accounts=('jhon@doe' 'marry@doe')

for account in ${accounts[@]}
do
psql postgresql://edunota:edunota@localhost:5432/edunota <<EOF
   WITH acc 
   AS ( INSERT INTO Accounts (email, password)
        VALUES ('$account', '1234') returning * ) 
    INSERT INTO Profiles (fk_account_id) VALUES ((SELECT id FROM acc));
EOF
done



# Insert institution, faculty and faculty user
psql postgresql://edunota:edunota@localhost:5432/edunota <<EOF
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

