with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;

package body entreprise is
	
	
Function Compare_entreprise(L: T_Liste_Entreprise; nom: T_Mot) return boolean is
Begin
	if L/=NULL then
		if L.Entreprise.Nom=nom then
			return false;
		else
			return Compare_entreprise(L.suiv, nom);
		end if;
	else
		return true;
	end if;
end Compare_entreprise;
	
--------------------------------------------------------------------------------------------
	
function recherche_pteur_ent(L: T_Liste_Entreprise; nom: T_Mot) return T_Liste_Entreprise is
	Begin
		if L/=NULL then
			if L.Entreprise.Nom=nom then
				return L;
			else
				return recherche_pteur_ent(L.suiv, nom);
			end if;
		else
			return NULL;
		end if;
end recherche_pteur_ent;	
	
-------------------------------------------------------------------------------------------- 	

Procedure Saisie_Entreprise (E : out T_Entreprise) is
	option : integer;
	Begin 
		put("Saisir le nom de l'entreprise : "); 
		Saisie_T_Mot(E.Nom);
	    put("Saisir la date du dernier audit");
		Saisie_T_Date(E.Date_dernier_audit); new_line;
	    put_line("Saisir le resulat du dernier audit");
		put_line("Tapez 1 pour Positif");
		put_line("Tapez 2 pour Negatif");
		put_line("Tapez 3 pour Problematique");
		put_line("Tapez 4 pour Sans_audit");
		get(option);
		loop
			case option is
				when 1 => E.Resulat_Dernier_Audit := Positif; exit;
		    	when 2 => E.Resulat_Dernier_Audit := Negatif; exit;
		    	when 3 => E.Resulat_Dernier_Audit := Problematique; exit;
		    	when 4 => E.Resulat_Dernier_Audit := sans_audit; exit;				
				when others => put ("Votre saisie est erronee, ressaisissez..");
			end case;
		end loop;
end Saisie_Entreprise;
   
-------------------------------------------------------------------------------------------- 

Procedure Ajout_Entreprise (LTete : in out T_tete_Liste_Entreprise) is
	E : T_Entreprise;
	Begin
		Saisie_Entreprise(E);
		LTete.tete:=new T_UneEntreprise'(E,LTete.tete);
End Ajout_Entreprise;
   
-------------------------------------------------------------------------------------------- 

Procedure Suppr_Entreprise(FT_t_Entreprise: in out T_tete_Liste_Entreprise) is
	En:T_Mot;
	TEn :T_Liste_Entreprise;
	Begin
   		TEn := FT_t_Entreprise.Tete;
		Saisie_T_Mot(En);
		if En=TEn.Entreprise.Nom then			
        	FT_t_Entreprise.tete := FT_t_Entreprise.tete.suiv;
		else
      		while TEn.suiv.entreprise.nom /= En loop
    			TEn := TEn.suiv;
			end loop;
       		TEn.suiv := TEn.suiv.suiv;
		end if;
end Suppr_Entreprise;

--------------------------------------------------------------------------------------------

Procedure Affiche_Entreprise (E : in out T_Liste_Entreprise) is
	Begin
		if E/=NULL then
			put("Nom de l entreprise : "); put(E.Entreprise.Nom); new_line; 
			put("Date du dernier audit :");
			put(E.Entreprise.Date_dernier_audit.jour); put("/");
			put(E.Entreprise.Date_dernier_audit.mois); put("/");
			put(E.Entreprise.Date_dernier_audit.annee); new_line; 
			put("Resultat dernier audit:"); put(T_Resultat'image(E.Entreprise.Resulat_dernier_audit)); new_line;
			Affiche_Entreprise(E.suiv);  
		end if;
end Affiche_Entreprise;

end entreprise;










  
      
   
