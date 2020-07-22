table 38024259 "Brzi unos"
{

    fields
    {
        field(1; "Redni broj unosa"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Redni broj unosa';
        }
        field(2; "MBG/Porezni broj"; Code[13])
        {
            Caption = 'MBG/Porezni broj';

            trigger OnValidate()
            begin
                if "MBG/Porezni broj" <> '' then begin
                    if STRLEN("MBG/Porezni broj") <> 13 then
                        ERROR(msg001, STRLEN("MBG/Porezni broj"));
                    Modul11 := STRCHECKSUM("MBG/Porezni broj", '7654327654321', 11);
                    if Modul11 <> 0 then
                        ERROR(msg002);

                    recPosPar.RESET;
                    recPosPar.SETFILTER("Employee ID", "MBG/Porezni broj");
                    if recPosPar.FIND('-') then begin
                        "Broj poslovnog partnera" := recPosPar."No.";
                        Ime := recPosPar."First Name";
                        Prezime := recPosPar."Last Name";
                        "Sudionik II stupa MO" := recPosPar."Sudionik II stupa MO";
                        "Šifra općine" := recPosPar."Šifra općine";
                        "Šifra općine rada" := recPosPar."Šifra općine rada";
                        "Obveznik PDV-a" := recPosPar."Obveznik PDV-a";
                        "Postotak PDV-a" := recPosPar."Postotak PDV-a";
                        "Global Dimension 1 Code" := recPosPar."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := recPosPar."Global Dimension 2 Code";
                        Sex := recPosPar.Sex;
                        "Post Code" := recPosPar."Post Code";

                        "recŽirRačPosPar".RESET;
                        "recŽirRačPosPar".SETRANGE("Šifra djelatnika", "Broj poslovnog partnera");
                        "recŽirRačPosPar".SETRANGE("Glavni račun", true);
                        if "recŽirRačPosPar".FIND('-') then begin
                            "Šifra banke" := "recŽirRačPosPar"."Šifra banke";
                            Račun := "recŽirRačPosPar".Račun;
                        end else begin
                            "Šifra banke" := '';
                            Račun := '';
                        end;
                    end else begin
                        "Broj poslovnog partnera" := '';
                        Ime := '';
                        Prezime := '';
                        "Sudionik II stupa MO" := false;
                        "Šifra općine" := '';
                        "Obveznik PDV-a" := false;
                        "Postotak PDV-a" := 0;
                        "Šifra banke" := '';
                        Račun := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                        Sex := 0;
                        "Post Code" := '';
                    end;
                end else begin
                    "Broj poslovnog partnera" := '';
                    Ime := '';
                    Prezime := '';
                    "Sudionik II stupa MO" := false;
                    "Šifra općine" := '';
                    "Obveznik PDV-a" := false;
                    "Postotak PDV-a" := 0;
                    "Šifra banke" := '';
                    Račun := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    Sex := 0;
                    "Post Code" := '';
                end;
            end;
        }
        field(3; "Broj poslovnog partnera"; Code[20])
        {
            Caption = 'Broj poslovnog partnera';

            trigger OnValidate()
            begin
                if "Broj poslovnog partnera" <> '' then begin
                    if recPosPar.GET("Broj poslovnog partnera") then begin
                        "MBG/Porezni broj" := recPosPar."Employee ID";
                        Ime := recPosPar."First Name";
                        Prezime := recPosPar."Last Name";
                        "Sudionik II stupa MO" := recPosPar."Sudionik II stupa MO";
                        "Šifra općine" := recPosPar."Šifra općine";
                        "Šifra općine rada" := recPosPar."Šifra općine rada";
                        "Obveznik PDV-a" := recPosPar."Obveznik PDV-a";
                        "Postotak PDV-a" := recPosPar."Postotak PDV-a";
                        Sex := recPosPar.Sex;
                        "Post Code" := recPosPar."Post Code";
                        "Global Dimension 1 Code" := recPosPar."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := recPosPar."Global Dimension 2 Code";

                        "recŽirRačPosPar".RESET;
                        "recŽirRačPosPar".SETRANGE("Šifra djelatnika", "Broj poslovnog partnera");
                        "recŽirRačPosPar".SETRANGE("Glavni račun", true);
                        if "recŽirRačPosPar".FIND('-') then begin
                            "Šifra banke" := "recŽirRačPosPar"."Šifra banke";
                            Račun := "recŽirRačPosPar".Račun;
                        end else begin
                            "Šifra banke" := '';
                            Račun := '';
                        end;
                    end else begin
                        "MBG/Porezni broj" := '';
                        Ime := '';
                        Prezime := '';
                        "Sudionik II stupa MO" := false;
                        "Šifra općine" := '';
                        "Šifra općine rada" := '';
                        "Obveznik PDV-a" := false;
                        "Postotak PDV-a" := 0;
                        "Šifra banke" := '';
                        Račun := '';
                        Sex := 0;
                        "Post Code" := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                    end;
                end else begin
                    "MBG/Porezni broj" := '';
                    Ime := '';
                    Prezime := '';
                    "Sudionik II stupa MO" := false;
                    "Šifra općine" := '';
                    "Obveznik PDV-a" := false;
                    "Postotak PDV-a" := 0;
                    "Šifra banke" := '';
                    Račun := '';
                    Sex := 0;
                    "Post Code" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;
            end;
        }
        field(4; Ime; Text[30])
        {
            Caption = 'Ime';
        }
        field(5; Prezime; Text[30])
        {
            Caption = 'Prezime';
        }
        field(6; "Sudionik II stupa MO"; Boolean)
        {
            Caption = 'Sudionik II stupa MO';
        }
        field(7; "Šifra općine"; Code[20])
        {
            Caption = 'Šifra općine';
            TableRelation = "Općina";
        }
        field(8; "Obveznik PDV-a"; Boolean)
        {
            Caption = 'Obveznik PDV-a';

            trigger OnValidate()
            begin
                if "Obveznik PDV-a" = true then begin
                    recUgoSet.GET;
                    "Postotak PDV-a" := recUgoSet."Postotak PDV-a";
                end else begin
                    "Postotak PDV-a" := 0;
                end;
            end;
        }
        field(9; "Postotak PDV-a"; Decimal)
        {
            Caption = 'Postotak PDV-a';
        }
        field(10; "Indikator kontrole"; Boolean)
        {
            Caption = 'Indikator kontrole';
            Editable = false;
        }
        field(11; "Šifra banke"; Code[20])
        {
            Caption = 'Šifra banke';
            TableRelation = Banka;
        }
        field(12; "Račun"; Text[50])
        {
            Caption = 'Račun';
        }
        field(13; "Broj ugovora"; Code[20])
        {
            Caption = 'Broj ugovora';
            TableRelation = "Ugovori UOD".Broj WHERE("Izvršitelj Broj" = FIELD("Broj poslovnog partnera"));

            trigger OnValidate()
            begin
                if "Broj ugovora" <> '' then begin
                    if recUgo.GET("Broj ugovora") then begin
                        "Vrsta ugovora" := recUgo."Vrsta ugovora";
                        "Radno mjesto" := recUgo."Radno mjesto";
                        "Bruto/Neto" := recUgo."Bruto/Neto";
                        "Iznos Obrade" := recUgo."Iznos Obrade";
                        "Valuta ugovora" := recUgo."Valuta ugovora";
                        "Osnova obračuna OO" := recUgo."Osnova obračuna OO";
                        "Osnova obračuna I" := recUgo."Osnova obračuna I";
                        "Osnova obračuna B" := recUgo."Osnova obračuna B";
                        "Osnova obračuna Z" := recUgo."Osnova obračuna Z";
                        "Osnova obračuna SSRR" := recUgo."Osnova obračuna SSRR";
                        "Datum ugovora" := recUgo."Datum ugovora";
                        "Šifra banke" := recUgo."Banka računa isplate";
                        Račun := recUgo."Račun isplate";
                    end else begin
                        "Vrsta ugovora" := '';
                        "Radno mjesto" := '';
                        "Bruto/Neto" := 0;
                        "Iznos Obrade" := 0;
                        "Valuta ugovora" := '';
                        "Osnova obračuna OO" := '';
                        "Osnova obračuna I" := '';
                        "Osnova obračuna B" := '';
                        "Osnova obračuna Z" := '';
                        "Osnova obračuna SSRR" := '';
                        "Datum ugovora" := 0D;
                        "Šifra banke" := '';
                        Račun := '';
                    end;
                end else begin
                    "Vrsta ugovora" := '';
                    "Radno mjesto" := '';
                    "Bruto/Neto" := 0;
                    "Iznos Obrade" := 0;
                    "Valuta ugovora" := '';
                    "Osnova obračuna OO" := '';
                    "Osnova obračuna I" := '';
                    "Osnova obračuna B" := '';
                    "Osnova obračuna Z" := '';
                    "Osnova obračuna SSRR" := '';
                    "Datum ugovora" := 0D;
                    "Šifra banke" := '';
                    Račun := '';
                end;
            end;
        }
        field(14; "Vrsta ugovora"; Code[20])
        {
            Caption = 'Vrsta ugovora';
            TableRelation = "Vrste UGOD".Broj;

            trigger OnValidate()
            begin
                if "Vrsta ugovora" <> xRec."Vrsta ugovora" then begin
                    if recVrsUgo.GET("Vrsta ugovora") then
                        "Osnova obračuna OO" := recUgo."Osnova obračuna OO"
                    else
                        "Osnova obračuna OO" := '';
                end;
            end;
        }
        field(15; "Radno mjesto"; Text[50])
        {
            Caption = 'Radno mjesto';
        }
        field(16; "Bruto/Neto"; Option)
        {
            Caption = 'Bruto/Neto';
            OptionMembers = Bruto,Neto;
        }
        field(17; "Iznos Obrade"; Decimal)
        {
            Caption = 'Iznos Obrade';
        }
        field(18; "Valuta ugovora"; Code[20])
        {
            Caption = 'Valuta ugovora';
            TableRelation = Currency;
        }
        field(19; "Datum ugovora"; Date)
        {
            Caption = 'Datum ugovora';
        }
        field(20; "Šifra općine rada"; Code[20])
        {
            Caption = 'Šifra općine rada';
            TableRelation = "Općina";
        }
        field(22; "Osnova obračuna OO"; Code[20])
        {
            Caption = 'Osnov osiguranja';
            TableRelation = "Općina";
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
            TableRelation = "Uvećani staž";
        }
        field(26; "Osnova obračuna SSRR"; Text[4])
        {
            Caption = 'Osnova obračuna SSRR';
        }
        field(33; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(34; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(38; "Br. serija poslov. partnera"; Code[10])
        {
            Caption = 'Br. serija poslov. partnera';
            TableRelation = "No. Series";
        }
        field(39; Address; Text[30])
        {
            Caption = 'Address';
        }
    }

    keys
    {
        key(Key1; "Redni broj unosa")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        recUgoSet: Record "Ugovori Setup";
        recPosPar: Record "Poslovni partner UOD";
        "recŽirRačPosPar": Record "Žiro račun poslovnog partnera";
        recUgo: Record "Ugovori UOD";
        recVrsUgo: Record "Vrste UGOD";
        Modul11: Integer;
        msg001: Label 'Neodgovarajući broj znamenaka: %1!';
        msg002: Label 'Neodgovarajući kontrolni broj!';
        DimMgt: Codeunit DimensionManagement;

    [Scope('OnPrem')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}

