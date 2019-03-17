with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

package Entreprise is
   -- types
-- on doit encore le mettre ici ?
--Type T_Mois is (Janvier, Fevrier, Mars, Avril, Mai, Juin, Juillet, Aout, Septembre, Octobre, Novembre, Decembre) ;
--Subtype Integer_jour is integer range 1..31 ;
--Type T_Date is record
--    J : Integer_jour ;
--    Mois : T_Mois ;
--    Annee : positive ;
--End record ; 

subtype T_Mot is String (1..30) := others = ‘ ‘) ;  -- Idem que pour T_Date

Type T_Resultat is (positif, negatif, problematique) ;

Type T_Entreprise is record
    Nom : T_Mot ;
    Date_dernier_audit : T_Date ;
    Resulat_dernier_audit : T_Resulat ;
end record ;

Type T_UneEntreprise ;
Type T_Liste_Entreprise is access of T_UneEntreprise ;
Type T_UneEntreprise is record
    Entreprise : T_Entreprise ;
    Suiv : T_Liste_Entreprise ;
end record ; 

-- Fonctions et procédures
