with ada.text_io, ada.integer_text_io,ada.Float_Text_IO;
use  ada.text_io, ada.integer_text_io,ada.Float_Text_IO;

package employe is
   
-- types
	subtype integer_jour is integer range 1..31 ;
	subtype integer_mois is integer range 1..12 ;
	subtype T_Mot is string (1..30);
	
	Type T_Date is record
    	jour : integer_jour := 1 ;
    	mois : integer_mois := 1 ;
		annee : integer :=0 ;
	end record ;
   
	Type T_Employe is record
		NomE : T_Mot ;
    	PrenomE : T_Mot ;
    	Profession : boolean ;
    	Retour : T_Date ;
    	Disponible : boolean := true ; -- true si pas en audit
    	Nb_jours_audit : integer := 0 ;
	end record ;

	Type T_UnEmploye ;
	Type T_Liste_Employe is access T_UnEmploye ;
	Type T_UnEmploye is record
		Employe : T_Employe ;
		Suiv : T_Liste_Employe ; 
	end record ;


-- Fonctions et procedures
Procedure Saisie_T_Mot(mot: out T_Mot);
Procedure Saisie_T_Date(date: out T_Date);
Function Compare_T_Date(date1, date2: T_Date) return boolean;
Function Saisie_Profession return boolean;
Procedure Saisie_Employe (E: out T_Employe);
Procedure Recrutement (tete : in out T_Liste_Employe; E : out T_Employe);
Procedure Depart (l: in out T_Liste_Employe);
Procedure Affiche_Employe (L: in out T_Liste_Employe);
Procedure Depart_Conges (E: out T_Employe; L: in out T_Liste_Employe; dateRetour: out T_Date; dateDuJour : T_Date);
Function employe_disponible(E: T_Liste_Employe; Profession: boolean) return T_Liste_Employe;


end employe;















