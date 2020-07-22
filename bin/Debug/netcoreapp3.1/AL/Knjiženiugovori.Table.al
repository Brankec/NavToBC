table 38024258 "Knjiženi ugovori"
{

    fields
    {
        field(1; Broj; Code[20])
        {
            Caption = 'Broj';
        }
        field(2; "Vrsta ugovora"; Code[20])
        {
            Caption = 'Vrsta ugovora';
            TableRelation = "Vrste UGOD".Broj;

            trigger OnValidate()
            begin
                if "Vrsta ugovora" <> xRec."Vrsta ugovora" then begin
                    if VrsteUgovora.GET("Vrsta ugovora") then
                        "Vrsta ugovora za obradu" := VrsteUgovora.Vrsta
                    else
                        "Vrsta ugovora za obradu" := 0;
                end;
            end;
        }
        field(3; "Izvršitelj Broj"; Code[20])
        {
            Caption = 'Izvršitelj Broj';
            TableRelation = "Poslovni partner UOD"."No.";

            trigger OnValidate()
            begin
                if "Izvršitelj Broj" <> xRec."Izvršitelj Broj" then begin
                    if Employee.GET("Izvršitelj Broj") then
                        "Izvršitelj puno Ime" := Employee."Last Name" + ' ' + Employee."First Name"
                    else
                        "Izvršitelj puno Ime" := '';
                end;
            end;
        }
        field(4; "Izvršitelj puno Ime"; Text[50])
        {
            Caption = 'Izvršitelj puno Ime';
        }
        field(5; "Radno mjesto"; Text[50])
        {
            Caption = 'Radno mjesto';
        }
        field(6; "Opis Posla"; Text[250])
        {
            Caption = 'Opis Posla';
        }
        field(7; "Datum ugovora"; Date)
        {
            Caption = 'Datum ugovora';
        }
        field(8; "Datum roka izvršenja"; Date)
        {
            Caption = 'Datum roka izvršenja';
        }
        field(9; "Vrijeme izvršenja"; Text[100])
        {
            Caption = 'Vrijeme izvršenja';
        }
        field(10; "Dodatne opaske"; Text[250])
        {
            Caption = 'Dodatne opaske';
        }
        field(11; "Račun isplate"; Text[50])
        {
            Caption = 'Račun isplate';

            trigger OnValidate()
            begin
                //IF "Račun isplate" <> xRec."Račun isplate" THEN BEGIN
                if RecZiroRacuni.GET("Račun isplate", "Izvršitelj Broj") then begin
                    "Banka računa isplate" := RecZiroRacuni."Šifra banke";
                end else begin
                    "Banka računa isplate" := '';
                end;
                //END;
            end;
        }
        field(12; "Bruto/Neto"; Option)
        {
            Caption = 'Bruto/Neto';
            OptionMembers = Bruto,Neto;
        }
        field(13; "Iznos ugovora"; Decimal)
        {
            Caption = 'Iznos ugovora';
        }
        field(14; "Iznos isplate"; Decimal)
        {
            Caption = 'Iznos isplate';
        }
        field(15; "Iznos Obrade"; Decimal)
        {
            Caption = 'Iznos Obrade';
        }
        field(16; "Valuta ugovora"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Banka računa isplate"; Text[50])
        {
            Caption = 'Banka računa isplate';
        }
        field(19; "Zaključen"; Boolean)
        {
            Caption = 'Closed';
        }
        field(20; "Vrsta ugovora za obradu"; Option)
        {
            Caption = 'Vrsta ugovora za obradu';
            Description = 'Ugovori o djelu,Isplate članovima nadzornih odbora,Autorski honorari';
            OptionMembers = "Ugovori o djelu","Isplate članovima nadzornih odbora","Autorski honorari";
        }
        field(22; "Osnova obračuna OO"; Code[20])
        {
            Caption = 'Osnov osiguranja';
            TableRelation = "Osnovica osiguranja";
        }
        field(23; "Osnova obračuna I"; Code[20])
        {
            Caption = 'Invalidnost';
            TableRelation = Invaliditet;
        }
        field(24; "Osnova obračuna B"; Code[20])
        {
            Caption = 'Uvećani staž';
            TableRelation = "Uvećani staž"."Šifra";
        }
        field(25; "Osnova obračuna Z"; Code[20])
        {
            Caption = 'Zdravstveno osiguranje';
            TableRelation = "Zdrav. osiguranje";
        }
        field(26; "Osnova obračuna SSRR"; Text[4])
        {
            Caption = 'Osnova obračuna SSRR';
        }
        field(44; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                MODIFY;
            end;
        }
        field(45; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
                MODIFY;
            end;
        }
        field(53; "Oznaka primici obv. doprinosa"; Code[20])
        {
            Description = 'JOPPD';
            TableRelation = "Oznaka obveze doprinosa";
        }
    }

    keys
    {
        key(Key1; Broj)
        {
            Clustered = true;
        }
        key(Key2; "Izvršitelj Broj")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(msg001);
    end;

    trigger OnInsert()
    begin
        Broj := MgtBrSerije.GetNextNo('UOD-UGOVOR', WORKDATE, true);
    end;

    var
        Employee: Record "Poslovni partner UOD";
        MgtBrSerije: Codeunit NoSeriesManagement;
        VrsteUgovora: Record "Vrste UGOD";
        RecZiroRacuni: Record "Žiro račun poslovnog partnera";
        msg001: Label 'Ne možete obrisati knjiženi ugovor!';

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee,"No.",FieldNumber,ShortcutDimCode);
        MODIFY;
        */

    end;
}

