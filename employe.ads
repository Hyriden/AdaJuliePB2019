WITH Ada.Text_IO, Ada.Integer_Text_IO, Ada.Integer_Float_IO;
use Ada.Text_Io, Ada.Integer_Text_Io, Ada.Integer_Float_Io;

package Employe is
   
-- types
   Subtype T_Mot is string (1..30) := others = ' ') ;
   Pasconge:T_date;
   Pasconge.Annee:=0;
   
Type T_Employe is record
    NomE : T_Mot ;
    PremonE : T_ Mot ;
    Profession : T_Profession ;
    Retour : T_Date := Pasconge;
    Diponible : boolean ; -- true si pas en audit
    Nb_jours_audit : integer ;
end record ;

Type T_UnEmploye ;
Type T_Liste_Employe is access of T_UnEmploye ;
Type T_UnEmploye is record
    Employe : T_Employe ;
    Suiv : T_Liste_Employe ; 
End record ; 

-- je ne sais pas si les dates vont dans cet ads car on en a besoin aussi pour kes kits
Type T_Mois is (Janvier, Fevrier, Mars, Avril, Mai, Juin, Juillet, Aout, Septembre, Octobre, Novembre, Decembre) ;
subtype Integer_Jour is Integer range 1..31 ;
Type T_Date is record
    J : Integer_jour ;
    Mois : T_Mois ;
    Annee : positive ;
End record ; 


-- Fonctions et procedures
procedure Saisie_Employe (E: out T_Employe; D: T_Date);
procedure Recrutement (Tete : in out T_Liste_Employe; K : Positive; E : T_Employe; Erreur : out Boolean);
procedure Depart (E: in T_Employe; L: in out T_Liste_Employe); --N,P : T_Mot; Ok : out boolean)
procedure Affiche_Employes (L: in T_Liste_Employe)
   function Depart_Conges (E: in T_Unemploye; L: in out T_Liste_Employe) return Boolean;
end Employe;
