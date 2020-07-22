table 38024253 "Ugovori Setup"
{
    Caption = 'Contracts Setup';
    DrillDownPageID = "Contract Setup";
    LookupPageID = "Contract Setup";

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Broj. serija ugovora"; Code[20])
        {
            Caption = 'Broj. serija ugovora';
            TableRelation = "No. Series";
        }
        field(3; "Broj. serija isplata"; Code[20])
        {
            Caption = 'Broj. serija isplata';
            TableRelation = "No. Series";
        }
        field(4; "RS Osoba za kontakt"; Text[50])
        {
            Caption = 'RS Osoba za kontakt';
        }
        field(5; "RS Telefon za kontakt"; Text[10])
        {
            Caption = 'RS Telefon za kontakt';
        }
        field(6; "RS E-mail adresa"; Text[30])
        {
            Caption = 'RS E-mail adresa';
        }
        field(7; "RS Vrsta obveznika"; Code[10])
        {
            Caption = 'RS Vrsta obveznika';
        }
        field(8; "RS Vrsta uplate"; Code[10])
        {
            Caption = 'RS Vrsta uplate';
        }
        field(9; "RS Disketa"; Option)
        {
            Caption = 'RS Disketa';
            Description = 'Direktna izrada,Izlaz prema Regosu';
            OptionMembers = "Direktna izrada","Izlaz prema Regosu";
        }
        field(10; "RS pozicija diskete"; Text[50])
        {
            Caption = 'RS pozicija diskete';
        }
        field(11; "Obveznik PDV-a"; Option)
        {
            Caption = 'Obveznik PDV-a';
            Description = 'Da,Ne';
            OptionMembers = Da,Ne;
        }
        field(12; "Postotak PDV-a"; Decimal)
        {
            Caption = 'Postotak PDV-a';
        }
        field(13; "Broj. serija posl. partnera"; Code[20])
        {
            Caption = 'Broj. serija posl. partnera';
            TableRelation = "No. Series";
        }
        field(15; "Broj. serija upućivanja u ino."; Code[20])
        {
            Caption = 'Broj. serija upućivanja u ino.';
            TableRelation = "No. Series";
        }
        field(50000; "Prosječna osnovica"; Decimal)
        {
            Description = 'Dorada po zahtjevu';
        }
        field(60001; Temeljnica; Code[10])
        {
            Caption = 'Temeljnica';
            TableRelation = "Gen. Journal Template";
        }
        field(60005; "Paket temeljnice"; Code[10])
        {
            Caption = 'Paket temeljnice';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD(Temeljnica));
        }
        field(60100; "Putanja za temeljnicu"; Text[50])
        {
            Caption = 'Putanja za temeljnicu';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

