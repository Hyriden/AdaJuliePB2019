with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;

package body entreprise is
	

Procedure Saisie_Entreprise (E : out T_Entreprise) is
	option : integer;
	Begin 
		put("Saisir le nom de l'entreprise");
		Saisie_T_Mot(E.Nom); new_line;
	    put("Saisir la date du dernier audit");
		Saisie_T_Date(E.Date_dernier_audit); new_line;
	    put_line("Saisir le résulat du dernier audit");
		put_line("Tapez 1 pour Positif");
		put_line("Tapez 2 pour Négatif");
		put_line("Tapez 3 pour Problématique");
		get(option);
		loop
			case option is
				when 1 => E.Resulat_Dernier_Audit := Positif; exit;
		    	when 2 => E.Resulat_Dernier_Audit := Negatif; exit;
		    	when 3 => E.Resulat_Dernier_Audit := Problematique; exit;
				when others => put ("Votre saisie est erronée, ressaisissez..");
			end case;
		end loop;
end Saisie_Entreprise;
   
-------------------------------------------------------------------------------------------- 

Procedure Ajout_Entreprise (Tete : in out T_Liste_Entreprise) is
	E : T_Entreprise;
	uneEntreprise:T_Liste_Entreprise;
	Begin
		Saisie_Entreprise(E);
		uneEntreprise:=new T_UneEntreprise'(E,tete);
		tete:=uneEntreprise;
End Ajout_Entreprise;
   
-------------------------------------------------------------------------------------------- 

Procedure Suppr_Entreprise (L: in out T_Liste_Entreprise) is
	Procedure Delete_Entreprise (L: in out T_Liste_Entreprise; nomE: in T_Mot) is
		Begin
			if L/=NULL then
				if L.Entreprise.Nom = nomE then
					L:=L.suiv;
				end if;
				Delete_Entreprise(L.suiv, nomE);
			end if;
	end Delete_Entreprise;			
	nomE:T_Mot;
	Begin
		put("Saisir le nom de l'entreprise à supprimer");
		Saisie_T_Mot(nomE); new_line;
		Delete_Entreprise(L, nomE);      
end Suppr_Entreprise;

end entreprise;










  
      
   
