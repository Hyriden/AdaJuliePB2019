with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe;

package entreprise is
   -- types

Type T_Resultat is (positif, negatif, problematique) ;

Type T_Entreprise is record
    Nom : T_Mot ;
    Date_dernier_audit : T_Date ;
    Resulat_dernier_audit : T_Resultat ;
end record ;

Type T_UneEntreprise ;
Type T_Liste_Entreprise is access T_UneEntreprise ;
Type T_UneEntreprise is record
    Entreprise : T_Entreprise ;
    Suiv : T_Liste_Entreprise ;
end record ; 

Type T_tete_Liste_Entreprise is record 
	tete:T_Liste_Entreprise;
end record;

-- Fonctions et proc�dures
Procedure Saisie_Entreprise (E : out T_Entreprise);
Procedure Ajout_Entreprise (Tete : in out T_Liste_Entreprise);
Procedure Suppr_Entreprise (L: in out T_Liste_Entreprise);
Function retournePtENtreprise(L: T_Liste_Entreprise; Entreprise: T_Mot) return T_Liste_Entreprise;


end entreprise;
