with Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;
use  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Float_Text_Io;

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

Procedure Saisie_Nature (nat: in out T_Nature) is
	option: integer;
	Begin
		put_line("Veuillez saisir la nature du kit");
		put_line("Tapez 1 pour Veterinaire");
		put_line("Tapez 2 pour Phyto-sanitaire");
		put_line("Tapez 3 pour Microbiologie");
		put_line("Tapez 4 pour Analyse_Composition");
		loop
			get(option); skip_line;
			case option is
				when 1 => nat:=Veterinaire;
				when 2 => nat:=Phyto_sanitaire;
				when 3 => nat:=Microbiologie;
				when 4 => nat:=Analyse_Composition;
	    		when others => put ("Votre saisie est erronée, ressaisissez..");
			end case;
		end loop;
end Saisie_Nature;


Procedure Saisie_Kit (K : in out T_Kit; L : in out T_Liste_Kit; dateDuJour : in T_Date) is
	datePeremption : T_Date;
	bool : boolean;
Begin
	Saisie_Nature(K.Nature);
	put_line("Veuillez saisir l'identifiant du kit");
	loop
	   get(K.Identifiant); skip_line;
	   bool:=Compare_IdKit(L,K.Identifiant);
	   exit when bool;
	   put("Identifiant déja utlisé, ressaisissez..");
	end loop;  
	put_line("Veuillez saisir la date de péremption du kit");
	loop
		Saisie_T_Date(datePeremption);
		bool:=Compare_T_Date(datePeremption, dateDuJour);
		exit when bool;
		put("La date de peremption du kit est inférieure ou égale à la date du jour, ressaisissez..");
	end loop;
end Saisie_Kit;

-------------------------------------------------------------------------------------------- 
 
Procedure Ajout_Kit (tete : in out T_Liste_Kit; K : out T_Kit; L : in out T_Liste_Kit; dateDuJour : in T_Date) is
	unKit:T_Liste_Kit;
	Begin
		Saisie_Kit(K, L, dateDuJour);
		unKit:=new T_UnKit'(K,tete);
		tete:=unKit;
end Ajout_Kit;
   
-------------------------------------------------------------------------------------------- 
 
Procedure Suppr_Kit (L: in out T_Liste_Kit) is
	Identifiant: integer;
	bool: boolean;
	Begin
		loop
			put_line("Veuillez saisir l'identifiant du kit à supprimer");
			get(Identifiant); new_line;
			bool:=Compare_IdKit(L,Identifiant);
			exit when bool=false;
			put("Kit innexistant, ressaisissez..");
		end loop;
		Delete_Kit(L, Identifiant);
end Suppr_Kit;
   
-------------------------------------------------------------------------------------------- 

Procedure Delete_Kit (L: in out T_Liste_Kit; Identifiant: in integer) is
	Begin
		if L/=NULL then
			if L.Kit.Identifiant=Identifiant then
				L:=L.suiv;
			end if;
			Delete_Kit(L.suiv, Identifiant);
		end if;
end Delete_Kit;
		
-------------------------------------------------------------------------------------------- 			
			
Procedure Affiche_Kit (L : in out T_Liste_Kit) is
	Begin
		if L/=NULL then
			put("Nature du kit"); put(T_Nature'image(L.Kit.Nature)); new_line;
			put("Identifiant du kit:"); Put(L.Kit.Identifiant); new_line;
			put("Actuellement utilisé:");
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
		end if;
		Affiche_Kit(L.suiv);
End Affiche_Kit;

-------------------------------------------------------------------------------------------- 			

Function kit_disponible(K: T_Liste_Kit; Nature: T_Nature) return T_Liste_Kit is 
	bool:boolean;
	Begin
		if K=NULL then
			return NULL;
		else
			if K.Kit.Utilise=false and K.Kit.Nature=Nature then
				return K;
			else
				return kit_disponible(K.suiv,Nature);
			end if;
		end if;
	end kit_disponible
				
				











End Kit;












