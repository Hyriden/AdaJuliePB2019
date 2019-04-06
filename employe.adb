with ada.text_io, ada.integer_text_io,ada.Float_Text_IO;
use  ada.text_io, ada.integer_text_io,ada.Float_Text_IO;

Package body employe is
	
Procedure Saisie_T_Mot(mot: out T_Mot) is
k:integer;
Begin
	loop
		Begin
	   		get_line(mot,k);
			exit;
			exception
			when constraint_error => put_line("Erreur de saisie du mot, ressaisissez..");
		end;
	end loop;
end Saisie_T_Mot;

---------------------------------------------------------------------------------------  

Procedure Saisie_T_Date(date: out T_Date) is
	Begin
		loop
			put_line("Saisie jour :");
			get(date.jour);skip_line;
			put_line("Saisie mois :");
			get(date.mois);skip_line;
			put_line("Saisie année :");
			get(date.annee);skip_line;
			case date.mois is
				when 2 =>
					if (date.annee mod 4=0 and date.annee mod 100/=0) or date.annee mod 400=0 then
						exit when date.jour<=29;
					else 
						exit when date.jour<=28;
					end if;
				when 4 | 6 | 9 | 11 =>
					exit when date.jour<=30;
				when others =>
				exit;
			end case;
			put("Date impossible, ressaisissez..");		
		end loop;		
end Saisie_T_Date;

---------------------------------------------------------------------------------------  

Function Compare_T_Date(date1, date2: T_Date) return boolean is
	Begin
	if date1.annee>date2.annee then
		return true;
	elsif date1.annee<date2.annee then
		return false;
	else
		if date1.mois>date2.mois then
			return true;
		elsif date1.mois<date2.mois then
			return false;
		else
			if date1.jour>date2.jour then
				return true;
			else return false;
			end if;
		end if;
	end if;
end Compare_T_Date;

---------------------------------------------------------------------------------------  

Function Saisie_Profession return boolean is
	option: integer;
	Begin
		Put_line("1 => Technicien , 2 => Ingénieur");   
		loop
			get(option); Skip_Line;
			exit when option=1 or option=2;
			put("Erreur saisie");
		end loop;
		if option=1 then
			return true;
		else
			return false;
		end if;
end Saisie_profession;

---------------------------------------------------------------------------------------  
	
Procedure Saisie_Employe (E: in out T_Employe) is
	Begin	
	Put_line("Veuillez saisir le nom de l'employé");
	Saisie_T_Mot(E.NomE);
	
	Put_line("Veuillez saisir le prénom de l'employé");
	Saisie_T_Mot(E.PrenomE);
	
	E.Profession:=Saisie_Profession; 
	   		
 end Saisie_Employe;

---------------------------------------------------------------------------------------  

Procedure Recrutement (tete : in out T_Liste_Employe) is
	E : T_Employe;
	Begin
		Saisie_Employe(E);
		tete:=new T_UnEmploye'(E,tete);
end Recrutement;

---------------------------------------------------------------------------------------      

Procedure Depart (L: in out T_Liste_Employe) is 
	E:T_Employe;
	Procedure Supp_Employe (L: in out T_Liste_Employe; E: in out T_Employe) is 
		Begin
			if L=NULL then
				put("Employé non trouvé ou indisponible");
			else
				if E.NomE=L.Employe.NomE and E.PrenomE=L.Employe.PrenomE and E.Profession=L.Employe.Profession and L.Employe.Disponible then
					L:=L.suiv;
				end if;
				Supp_Employe(L.suiv, E);
			end if;
	end Supp_Employe;
	Begin
		Saisie_Employe(E);	
		Supp_Employe(L, E);
end Depart;

---------------------------------------------------------------------------------------  
         
Procedure Affiche_Employe (L: in out T_Liste_Employe) is
	Begin
		if L /= null then
			put("Nom : "); put(L.Employe.NomE); new_line; 
			put("Prénom : "); put(L.Employe.PrenomE); new_line;
			put("Profession : ");new_line; 
			put("Profession : ");
			if L.Employe.Profession then
				put_line("Technicien");
			else
				put_line("Ingénieur");
			end if;
			put("Congé : ");
			if L.Employe.Retour.Annee=0 then
				put("Non");new_line; 
			else
				put("Retour le");
				put(L.Employe.Retour.jour); put("/"); 
				put(L.Employe.Retour.mois); put("/");
				put(L.Employe.Retour.annee); new_line; 
      	  		L := L.suiv;
			end if;
			put("Disponibe : ");
			if L.Employe.Disponible then
				put("Oui"); new_line;
			else
				put("Non"); new_line;
			end if;
			put("Nombre de jours en audit : ");
			put(L.Employe.Nb_jours_audit);
			
			Affiche_Employe(L.suiv);			
		end if;
End Affiche_Employe;

---------------------------------------------------------------------------------------  
       
Procedure Depart_Conges (E: out T_Employe; L: in out T_Liste_Employe; dateRetour: out T_Date; dateDuJour : T_Date) is
	bool:boolean;
	Begin
	    put("Saisir l'employé qui part en congé");
		Saisie_Employe(E);
		put("Saisir la date du retour de l'employé");
		Saisie_T_Date(dateRetour);
		if E.Disponible then
			loop
				Saisie_T_Date(dateRetour);
				bool:=Compare_T_Date(dateRetour, dateDuJour);
				exit when bool;
				put("La date du retour est inférieure ou égale à la date du jour, ressaisissez..");
			end loop;
			E.Retour:=dateRetour;
		else
			put("Employé actuellement en audit, la prise de congés est impossible");
		end if;
end Depart_Conges;

---------------------------------------------------------------------------------------  

Function employe_disponible(E, noob: in out T_Liste_Employe; Profession: boolean; dateDuJour: T_Date) return T_Liste_Employe is 
	bool: boolean;
	Begin
		if E=NULL and noob=NULL then
			return NULL;
		elsif E=NULL then
			bool:=Compare_T_Date(noob.Employe.Retour, dateDuJour);
			if noob.Employe.Profession=Profession and bool=false and noob.Employe.Disponible=true then
				return noob;
			else
				return NULL;
			end if;
		else
			bool:=Compare_T_Date(E.Employe.Retour, dateDuJour);
			if E.Employe.Profession=Profession and bool=false and E.Employe.Disponible=true then
				if noob.Employe.Nb_jours_audit>E.Employe.Nb_jours_audit then
					noob:=E;
				end if;
			end if;
		return employe_disponible(E.suiv, noob, Profession, dateDuJour);
		end if;
end employe_disponible;
end employe;














