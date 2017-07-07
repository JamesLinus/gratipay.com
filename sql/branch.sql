BEGIN;
    CREATE TYPE email_auth_intent AS ENUM ('sign-in');

    CREATE TABLE email_auth_nonces
    ( id                    serial                      PRIMARY KEY
    , email_address         text                        NOT NULL
    , email_id              integer                     REFERENCES emails
                                                          ON UPDATE CASCADE
                                                          ON DELETE CASCADE
    , intent                email_auth_intent           NOT NULL
    , nonce                 text                        NOT NULL
    , ctime                 timestamp with time zone    NOT NULL DEFAULT CURRENT_TIMESTAMP
    , UNIQUE (email_address, nonce)
    , CONSTRAINT sign_in_has_valid_email CHECK (intent != 'sign-in' OR email_id IS NOT NULL)
     );
END;
