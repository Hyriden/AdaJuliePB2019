with ada.text_io, ada.integer_text_io, ada.Float_Text_IO;
use  ada.text_io, ada.integer_text_io, ada.Float_Text_IO;

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
		NomE : T_Mot :=(others =>' ');
    	PrenomE : T_Mot :=(others =>' ');
    	Profession : boolean ;
    	Retour : T_Date ;
    	Disponible : boolean := true ; -- true si pas en audit
    	Nb_jours_audit : integer := 0 ;
		Nb_audit : integer := 0 ;
	end record ;

	Type T_UnEmploye ;
	Type T_Liste_Employe is access T_UnEmploye ;
	Type T_UnEmploye is record
		Employe : T_Employe ;
		Suiv : T_Liste_Employe ; 
	end record ;
	
	Type T_tete_Liste_Employe is record 
		tete:T_Liste_Employe;
	end record;

-- Fonctions et procedures

Procedure Saisie_T_Mot(mot: out T_Mot); -- Saisie generique d'un mot

Function Compare_nom(L: T_Liste_Employe; E: T_Employe) return boolean; --return false si employe dans la base

function recherche_pteur_emp(L: T_Liste_Employe; nomE: T_Mot) return T_Liste_Employe; -- retourne le pt d'un employe

Procedure Saisie_T_Date(date: out T_Date); --Saisie generique d'une date

Function Compare_T_Date(date1, date2: T_Date) return boolean; --return true si d1>d2

Function Saisie_Profession return boolean; -- Saisie generique profession

Procedure Saisie_Employe (E: in out T_Employe); -- appel des saisies

Procedure Recrutement (tete : in out T_Liste_Employe); -- ajout employe

Procedure Depart(FT_t_Employe: in out T_tete_Liste_Employe); -- suppression employe

Procedure Affiche_Employe (L: in out T_Liste_Employe; dateDuJour : T_Date);

Procedure Depart_Conges (L: in out T_Liste_Employe; dateDuJour : T_Date); -- Saisie d'un conge

Function employe_disponible(E, noob: T_Liste_Employe; Profession: boolean; dateDuJour: T_Date) return T_Liste_Employe; --return true si employe disponible

end employe;















