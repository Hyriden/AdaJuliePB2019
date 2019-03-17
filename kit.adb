with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

package Kit is

-- types
   type T_Nature is (Veterinaire, Culture, Microbiologie, Controle) ; 
--comme la date est dans plusieurs package peut etre faire un package date (qui verifie si on n'a pas de 31 fevrier et l'utiliser dans kit, employé ...
--Type T_Mois is (Janvier, Fevrier, Mars, Avril, Mai, Juin, Juillet, Aout, Septembre, Octobre, Novembre, Decembre) ;
--subtype Integer_Jour is Integer range 1..31 ;

--Type T_Date is record
--    J : Integer_jour ;
--    Mois : T_Mois ;
--    Annee : positive ;
--end record ; 

Type T_Kit is record
    Nature : T_Nature ;
    Identifiant : integer ;
    Nb_utilisation : integer :=0 ;
    Date_peremption : T_Date ;
    Utilise: boolean := false;
end record ; 

Type T_UnKit ;
Type T_Liste_Kit is acces of T_UnKit ;
Type T_UnKit is record
    Kit : T_Kit ;
    Suiv : T_Liste_Kit ;
End record ; 

-- Fonctions et procedures 
procedure Saisie_Kit (K : out T_Kit; D : T_Date);
procedure Ajout_Kit (Tete : in out T_Liste_Kit; K : Positive; Ki : T_Kit; Erreur : out Boolean);
Function Suppr_Kit (K: in T_Kit; L: in out T_Liste_Kit; Ok : out Boolean) return Boolean.
procedure Affiche_Kit (L : in T_Liste_Kit);
End kit;
   
