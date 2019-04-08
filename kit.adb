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
			put_line("Veuillez saisir l'identifiant du kit à supprimer");
			get(Identifiant); new_line;
			bool:=Compare_IdKit(T_t_Kit.tete, Identifiant);
			exit when bool=false;
			put("Kit innexistant, ressaisissez..");
		end loop;
		Delete_Kit(T_t_Kit, Identifiant);
end Suppr_Kit;
   
-------------------------------------------------------------------------------------------- 

Procedure Delete_Kit(T_t_Kit: in out T_tete_Liste_Kit; Identifiant: in integer) is
	Procedure Del_Kit(L : in out T_Liste_Kit; Identifiant: in integer) is
		Begin
			if L/=NULL then
				if L.Kit.Identifiant=Identifiant then
					L:=L.suiv;
				end if;
				Del_Kit(L.suiv, Identifiant);
			end if;
	end Del_Kit;	
	Begin
		if T_t_Kit.tete/=NULL then
			if T_t_Kit.tete.Kit.Identifiant=Identifiant then
				T_t_Kit.tete:=T_t_Kit.tete.suiv;
			end if;
		else
			Del_Kit(T_t_Kit.tete, Identifiant);
		end if;
end Delete_Kit;
		
-------------------------------------------------------------------------------------------- 			
			
Procedure Affiche_Kit (L : in out T_Liste_Kit) is
	Begin
		if L/=NULL then
			put("Nature du kit"); put(T_Nature'image(L.Kit.Nature)); new_line;
			put("Identifiant du kit:"); Put(L.Kit.Identifiant); new_line;
			put("Actuellement utilise:");
			if L.Kit.Utilise then
				put("Oui");
			else
				put("Non");
			end if;	new_line;
	        put("Nombre d'utilisation du kit:"); Put(L.Kit.Nb_Utilisation); new_line;
			put("Date de peremption :");
			put(L.Kit.Date_peremption.jour); put("/");
			put(L.Kit.Date_peremption.mois); put("/");
			put(L.Kit.Date_peremption.annee); new_line;   
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
	Procedure Kitdepasse(T_t_Kit: in out T_tete_Liste_Kit; K: in out T_Liste_Kit; dateDuJour: in T_Date) is
		bool:boolean;
		Begin
			if K/=NULL then
				if K.Kit.Utilise=false then
					bool:=Compare_T_Date(K.Kit.Date_peremption, dateDuJour);
					if bool=false then
	--					archive_kit();
						Delete_Kit(T_t_Kit, K.Kit.Identifiant);
					end if;
				end if;
				Kitdepasse(T_t_Kit, K.suiv, dateDuJour);
			end if;
	end Kitdepasse;
	Begin
		Kitdepasse(T_t_Kit, T_t_Kit.tete, dateDuJour);
end KitPerime;



end kit;












