table 38024262 "Ugovori UOD"
{
    // 051028 - mmatko - Brojčana serija se povlači s vrste ugovora
    // 051212 - mmatko - Dodao polja za rad s ugovorima u valuti

    DrillDownPageID = "Service contract card";
    LookupPageID = "Contract list";

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
                    if VrsteUgovora.GET("Vrsta ugovora") then begin
                        "Vrsta ugovora za obradu" := VrsteUgovora.Vrsta;
                        "Osnova obračuna OO" := VrsteUgovora."Osnova osiguranja";
                        recInvalidnost.RESET;
                        recInvalidnost.SETRANGE("Početno zadano", true);
                        if recInvalidnost.FIND('-') then
                            "Osnova obračuna I" := recInvalidnost.Šifra
                        else
                            "Osnova obračuna I" := '';

                        recUvecStaz.RESET;
                        recUvecStaz.SETRANGE("Početno zadano", true);
                        if recUvecStaz.FIND('-') then
                            "Osnova obračuna B" := recUvecStaz.Šifra
                        else
                            "Osnova obračuna B" := '';

                        recZdrav.RESET;
                        recZdrav.SETRANGE("Početno zadano", true);
                        if recZdrav.FIND('-') then
                            "Osnova obračuna Z" := recZdrav.Šifra
                        else
                            "Osnova obračuna Z" := '';

                        "Osnova obračuna SSRR" := '';
                    end else begin
                        "Vrsta ugovora za obradu" := 0;
                        "Osnova obračuna OO" := '';
                        "Osnova obračuna I" := '';
                        "Osnova obračuna B" := '';
                        "Osnova obračuna Z" := '';
                        "Osnova obračuna SSRR" := '';
                    end;
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
                    if PoslovniPartner.GET("Izvršitelj Broj") then begin
                        "Izvršitelj puno Ime" := PoslovniPartner."Last Name" + ' ' + PoslovniPartner."First Name";
                        "Global Dimension 1 Code" := PoslovniPartner."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := PoslovniPartner."Global Dimension 2 Code";
                    end else begin
                        "Izvršitelj puno Ime" := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    end;
                end;

                RecZiroRacuni.RESET;
                RecZiroRacuni.SETRANGE("Šifra djelatnika", "Izvršitelj Broj");
                RecZiroRacuni.SETRANGE("Glavni račun", true);
                if RecZiroRacuni.FIND('-') then
                    VALIDATE("Račun isplate", RecZiroRacuni.Račun)
                else begin
                    RecZiroRacuni.RESET;
                    RecZiroRacuni.SETRANGE("Šifra djelatnika", "Izvršitelj Broj");
                    if RecZiroRacuni.FIND('-') then
                        VALIDATE("Račun isplate", RecZiroRacuni.Račun)
                    else
                        ERROR(msg001, "Izvršitelj puno Ime");
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
                if "Račun isplate" <> xRec."Račun isplate" then begin
                    RecZiroRacuni.RESET;
                    RecZiroRacuni.SETFILTER("Šifra djelatnika", "Izvršitelj Broj");
                    RecZiroRacuni.SETFILTER(Račun, "Račun isplate");
                    if RecZiroRacuni.FIND('+') then
                        "Banka računa isplate" := RecZiroRacuni."Šifra banke"
                    else
                        "Banka računa isplate" := '';
                end;
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
            Caption = 'Iznos obrade';
        }
        field(16; "Valuta ugovora"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Valuta ugovora" = '' then begin
                    "Šifra banke za tečaj" := '';
                    "Šifra tečaja" := 0;
                    "Šifra datuma tečaja" := '';
                end;
            end;
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
            Description = 'Ugovori o djelu,Isplate članovima nadzornih odbora,Autorski honorari,Stipendije,Naknade članovima uprave';
            OptionMembers = "Ugovori o djelu","Isplate članovima nadzornih odbora","Autorski honorari",Stipendije,"Naknade članovima uprave";
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(22; "Osnova obračuna OO"; Code[20])
        {
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
        field(50; "Šifra banke za tečaj"; Code[20])
        {
            Caption = 'Šifra banke za tečaj';
            TableRelation = Banka;
        }
        field(51; "Šifra tečaja"; Option)
        {
            Caption = 'Šifra tečaja';
            OptionMembers = " ","Kupovni za efektivu","Kupovni za devize",Srednji,"Prodajni za devize","Prodajni za efektivu";
        }
        field(52; "Šifra datuma tečaja"; Code[20])
        {
            Caption = 'Šifra datuma tečaja';
            TableRelation = "Datum tečaja";
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

    trigger OnInsert()
    begin
        if Broj = '' then begin
            //---> 051028 - mmatko
            /*  UgovoriSetup.GET;
              UgovoriSetup.TESTFIELD("Broj. serija ugovora");
              NoSeriesMgt.InitSeries(UgovoriSetup."Broj. serija ugovora",xRec."No. Series",0D,Broj,"No. Series");*/
            VrsteUgovora.RESET;
            VrsteUgovora.GET("Vrsta ugovora");
            VrsteUgovora.TESTFIELD("Broj. serija");
            NoSeriesMgt.InitSeries(VrsteUgovora."Broj. serija", xRec."No. Series", 0D, Broj, "No. Series");
            //<--- 051028 - mmatko
        end;

    end;

    var
        PoslovniPartner: Record "Poslovni partner UOD";
        MgtBrSerije: Codeunit NoSeriesManagement;
        VrsteUgovora: Record "Vrste UGOD";
        RecZiroRacuni: Record "Žiro račun poslovnog partnera";
        UgovoriSetup: Record "Ugovori Setup";
        Ugovori: Record "Ugovori UOD";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        msg001: Label 'Za djelatnika %1 nije definiran niti jedan žiro račun!';
        recInvalidnost: Record Invaliditet;
        recUvecStaz: Record "Uvećani staž";
        recZdrav: Record "Zdrav. osiguranje";

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::60101,"No.", FieldNumber, ShortcutDimCode);
        MODIFY;
        */

    end;

    [Scope('OnPrem')]
    procedure AssistEdit(OldUgovori: Record "Ugovori UOD"): Boolean
    begin
        with Ugovori do begin
            Ugovori := Rec;
            UgovoriSetup.GET;
            UgovoriSetup.TESTFIELD("Broj. serija ugovora");
            if NoSeriesMgt.SelectSeries(UgovoriSetup."Broj. serija ugovora", OldUgovori."No. Series", "No. Series") then begin
                UgovoriSetup.GET;
                UgovoriSetup.TESTFIELD("Broj. serija ugovora");
                NoSeriesMgt.SetSeries(Broj);
                Rec := Ugovori;
                exit(true);
            end;
        end;
    end;
}

