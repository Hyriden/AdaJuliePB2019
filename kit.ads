with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;

package kit is

-- types
	Type T_Nature is (Veterinaire, Phyto_sanitaire, Microbiologie, Analyse_Composition) ; 
	
	Type T_Kit is record
		Nature : T_Nature ;
    	Identifiant : integer ;
    	Nb_utilisation : integer :=0 ;
    	Date_peremption : T_Date ;
    	Utilise: boolean := false ;
	end record ; 

	Type T_UnKit ;
	Type T_Liste_Kit is access T_UnKit ;
	Type T_UnKit is record
		Kit : T_Kit ;
    	Suiv : T_Liste_Kit ;
	End record ;
	
	Type T_tete_Liste_Kit is record 
		tete:T_Liste_Kit;
	end record;

-- Fonctions et procedures 

	Procedure Saisie_Nature (nat: out T_Nature); --saisie generique nature
	Function Compare_IdKit(L:T_Liste_Kit; Id: Integer) return boolean; --return false si kit dans la base
	function recherche_pteur_kit_id(L: T_Liste_Kit; Id: Integer) return T_Liste_Kit; -- return pt d'un kit
	Procedure Saisie_Kit (K : in out T_Kit; tete : in out T_Liste_Kit; dateDuJour: in T_Date); 
	Procedure Ajout_Kit(Ltete: in out T_tete_Liste_Kit; dateDuJour: in T_Date);
	Procedure Suppr_Kit (T_t_Kit: in out T_tete_Liste_Kit); -- saisie kit et appel de delete kit
	Procedure Delete_Kit(T_t_Kit: in out T_tete_Liste_Kit; Identifiant: in integer); -- suppression kit
	Procedure Affiche_Kit (L : in out T_Liste_Kit);
	Function kit_disponible(K, neuf: T_Liste_Kit; Nature: T_Nature) return T_Liste_Kit; -- return true si kit disponible
	Procedure KitPerime(T_t_Kit: in out T_tete_Liste_Kit; dateDuJour: in T_Date); -- appel delete pour les kits perimés non utilisés

end kit;

















   
