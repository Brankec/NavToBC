table 38024261 "Zaglavlje Knjižene Isplate"
{
    DrillDownPageID = 38017828;
    LookupPageID = 38017827;

    fields
    {
        field(1; Broj; Code[20])
        {
            Caption = 'Broj';
        }
        field(2; "Vrsta ugovora za obradu"; Option)
        {
            Caption = 'Vrsta ugovora za obradu';
            Description = 'Ugovori o djelu,Isplate članovima nadzornih odbora,Autorski honorari';
            OptionMembers = "Ugovori o djelu","Isplate članovima nadzornih odbora","Autorski honorari";
        }
        field(3; "Datum isplate"; Date)
        {
            Caption = 'Datum isplate';

            trigger OnValidate()
            begin
                recRedakKnjIspl.RESET;
                recRedakKnjIspl.SETRANGE("Broj Isplate", Broj);
                if recRedakKnjIspl.FIND('-') then
                    recRedakKnjIspl.MODIFYALL("Datum isplate", "Datum isplate");
            end;
        }
        field(4; "Godina za koju se vrši obrada"; Text[4])
        {
            Caption = 'Godina obrade';
        }
        field(5; "Mjesec za koji se vrši obrada"; Integer)
        {
            Caption = 'Mjesec obrade';
        }
        field(6; "Identifikator R-S obrasca"; Code[20])
        {
            Caption = 'Identifikator R-S obrasca';
            TableRelation = "JOPPD A str.";
        }
        field(7; "Faza rada"; Option)
        {
            Caption = 'Faza rada';
            Description = 'Otvaranje,Generiranje,Kontrola,Obračun,Zaključivanje';
            OptionMembers = Otvaranje,Generiranje,Kontrola,"Obračun","Zaključivanje";
        }
        field(8; Rekapitulacija; Boolean)
        {
            Caption = 'Rekapitulacija';
        }
        field(9; "Rekapitulacija po org. jed."; Boolean)
        {
            Caption = 'Rekapitulacija po org. jed.';
        }
        field(10; "R-S disketa"; Boolean)
        {
            Caption = 'R-S disketa';
        }
        field(11; "R-S hash"; Boolean)
        {
            Caption = 'R-S hash';
        }
        field(12; "R-S a stranica"; Boolean)
        {
            Caption = 'R-S a stranica';
        }
        field(13; "R-S b stranica"; Boolean)
        {
            Caption = 'R-S b stranica';
        }
        field(14; "Obračunski listići"; Boolean)
        {
            Caption = 'Obračunski listići';
        }
        field(15; "Zbrojni nalog, punjenje"; Boolean)
        {
            Caption = 'Zbrojni nalog, punjenje';
        }
        field(16; "Potvrda izvješća"; Boolean)
        {
            Caption = 'Potvrda izvješća';
        }
        field(31; "Identifikator JOPPD"; Code[20])
        {
            Description = 'JOPPD';
            TableRelation = "JOPPD A str.";
        }
    }

    keys
    {
        key(Key1; Broj)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(msg001);
    end;

    var
        msg001: Label 'Ne možete obrisati knjiženu isplatu!';
        recRedakKnjIspl: Record "Redak Knjižene Isplate";
}

