with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io, employe;

package body Kit is
	
Function Compare_IdKit(L:T_Liste_Kit; Id: Integer) return boolean is
Begin
	if L/=NULL then
		if L.Kit.Identifiant=Id then
			return false;
		else
			return Compare_IdKit(L.suiv, Id);
		end if;
	else
		return true;
	end if;
end Compare_IdKit;

-------------------------------------------------------------------------------------------- 

function recherche_pteur_kit_id(L: T_Liste_Kit; Id: Integer) return T_Liste_Kit is
	Begin
		if L/=NULL then
			if L.Kit.Identifiant=Id then
				return L;
			else
				return recherche_pteur_kit_id(L.suiv, Id);
			end if;
		else
			return NULL;
		end if;
end recherche_pteur_kit_id;

-------------------------------------------------------------------------------------------- 

Procedure Saisie_Nature (nat: out T_Nature) is
	option: integer;
	Begin
		put_line("Veuillez saisir la nature: ");
		put_line("Tapez 1 pour Veterinaire");
		put_line("Tapez 2 pour Phyto-sanitaire");
		put_line("Tapez 3 pour Microbiologie");
		put_line("Tapez 4 pour Analyse_Composition");
		loop
			get(option); skip_line;
			case option is
				when 1 => nat:=Veterinaire; exit;
				when 2 => nat:=Phyto_sanitaire; exit;
				when 3 => nat:=Microbiologie; exit;
				when 4 => nat:=Analyse_Composition; exit;
	    		when others => put ("Votre saisie est erronee, ressaisissez..");
			end case;
		end loop;
end Saisie_Nature;

-------------------------------------------------------------------------------------------- 

Procedure Saisie_Kit (K : in out T_Kit; tete : in out T_Liste_Kit; dateDuJour: in T_Date) is
	bool : boolean;
	
	Begin
		Saisie_Nature(K.Nature);
		put_line("Veuillez saisir l'identifiant du kit");
		loop
			get(K.Identifiant); skip_line;
			
	   	 	--bool:=Compare_IdKit(tete, K.Identifiant);
			bool:=true;
	   	 	exit when bool;
	   	 	put("Identifiant deja utlise, ressaisissez..");
		end loop;  
		put_line("Veuillez saisir la date de peremption du kit");
		loop
			Saisie_T_Date(K.date_Peremption);
			bool:=Compare_T_Date(K.date_Peremption, dateDuJour);
			exit when bool;
			put("La date de peremption du kit est inferieure ou egale à la date du jour, ressaisissez..");
		end loop;
end Saisie_Kit;

-------------------------------------------------------------------------------------------- 
 
Procedure Ajout_Kit(Ltete: in out T_tete_Liste_Kit; dateDuJour: in T_Date) is
	K:T_Kit;
	Begin	
		Saisie_Kit(K, Ltete.tete, dateDuJour);
		Ltete.tete:=new T_UnKit'(K,Ltete.tete);
end Ajout_Kit;
   
-------------------------------------------------------------------------------------------- 
 
Procedure Suppr_Kit (T_t_Kit: in out T_tete_Liste_Kit) is
	Identifiant: integer;
	bool: boolean;
	Begin
		loop
			put_line("Veuillez saisir l'identifiant du kit a supprimer");
			get(Identifiant); new_line;
			bool:=Compare_IdKit(T_t_Kit.tete, Identifiant);
			exit when bool=false;
			put("Kit innexistant, ressaisissez..");
		end loop;
		Delete_Kit(T_t_Kit, Identifiant);
end Suppr_Kit;
   
-------------------------------------------------------------------------------------------- 

Procedure Delete_Kit(T_t_Kit: in out T_tete_Liste_Kit; Identifiant: in integer) is
	TK:T_Liste_Kit;
	Begin
   		TK := T_t_Kit.tete;		
		if Identifiant=TK.Kit.Identifiant and TK.Kit.Utilise=false then			
        	T_t_Kit.tete := T_t_Kit.tete.suiv;
		else
      		while TK.suiv.Kit.Identifiant /= Identifiant loop
    			TK := TK.suiv;
			end loop;
     		if TK.suiv.Kit.Utilise = false then 
           		TK.suiv := TK.suiv.suiv;
      		end if;
		end if;
end Delete_Kit;
		
-------------------------------------------------------------------------------------------- 			
			
Procedure Affiche_Kit (L : in out T_Liste_Kit) is
	Begin
		if L/=NULL then
			put("Nature du kit"); put(T_Nature'image(L.Kit.Nature)); new_line;
			put("Identifiant du kit:"); Put(L.Kit.Identifiant,4); new_line;
			put("Actuellement utilise:");
			if L.Kit.Utilise then
				put("Oui");
			else
				put("Non");
			end if;	new_line;
	        put("Nombre d'utilisation du kit:"); Put(L.Kit.Nb_Utilisation,3); new_line;
			put("Date de peremption :");
			put(L.Kit.Date_peremption.jour,2); put("/");
			put(L.Kit.Date_peremption.mois,2); put("/");
			put(L.Kit.Date_peremption.annee,4); new_line;   
			Affiche_Kit(L.suiv);  
		end if;
End Affiche_Kit;

-------------------------------------------------------------------------------------------- 			

Function kit_disponible(K, neuf: T_Liste_Kit; Nature: T_Nature) return T_Liste_Kit is 
	Begin
		if K=NULL and neuf=NULL then
			return NULL;
		elsif K=NULL then
			if neuf.Kit.Utilise=false and neuf.Kit.Nature=Nature then
				return neuf;
			else 
				return NULL;
		end if;
		else
			if K.Kit.Utilise=false and K.Kit.Nature=Nature then
				if neuf.Kit.Nb_utilisation>K.Kit.Nb_utilisation then
					return kit_disponible(K.suiv, K, Nature);
				end if;
			end if;
			return kit_disponible(K.suiv, neuf, Nature);
		end if;
end kit_disponible;

-------------------------------------------------------------------------------------------- 

Procedure KitPerime(T_t_Kit: in out T_tete_Liste_Kit; dateDuJour: in T_Date) is
	K:T_Liste_Kit;
	bool:boolean;
	Begin
		K:=T_t_Kit.tete;
		while K/=NULL loop 			
			if K.Kit.Utilise=false then
				bool:=Compare_T_Date(K.Kit.Date_peremption, dateDuJour);
				if bool=false then
	--					archive_kit();
					if K=T_t_Kit.tete then			
    					T_t_Kit.tete := T_t_Kit.tete.suiv;
  					end if;
					
						K := K.suiv;				
				end if;
			end if;
		end loop;
end KitPerime;

end kit;












