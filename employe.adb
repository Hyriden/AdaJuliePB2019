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

Function Compare_nom(L: T_Liste_Employe; E: T_Employe) return boolean is
Begin
	if L/=NULL then
		if L.Employe.NomE=E.nomE and L.Employe.prenomE=E.prenomE then
			return false;
		else
			return Compare_nom(L.suiv, E);
		end if;
	else
		return true;
	end if;
end Compare_nom;

---------------------------------------------------------------------------------------  

Procedure Saisie_T_Date(date: out T_Date) is
	Begin
		loop
			put_line("Saisie jour :");
			get(date.jour);skip_line;
			put_line("Saisie mois :");
			get(date.mois);skip_line;
			put_line("Saisie annee :");
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
		Put_line("1 => Technicien , 2 => Ingenieur");   
		loop
			get(option); Skip_Line;
			exit when option=1 or option=2;
			put("Erreur saisie, ressaisissez..");
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
	Put_line("Veuillez saisir le nom de l'employe");
	Saisie_T_Mot(E.NomE);
	
	Put_line("Veuillez saisir le prenom de l'employe");
	Saisie_T_Mot(E.PrenomE);
	
	E.Profession:=Saisie_Profession; 
	   		
 end Saisie_Employe;

---------------------------------------------------------------------------------------  

Procedure Recrutement (tete : in out T_Liste_Employe) is
	E : T_Employe;
	bool:boolean;
	Begin
		Saisie_Employe(E);
		bool:=Compare_nom(tete, E);
		if bool then
			tete:=new T_UnEmploye'(E,tete);
		else
			put("Employe deja existant");
		end if;
end Recrutement;

---------------------------------------------------------------------------------------      

Procedure Depart(FT_t_Employe: in out T_tete_Liste_Employe) is
	E:T_Employe;
	TE :T_Liste_Employe;
	Begin
   		TE := FT_t_Employe.Tete;
		Saisie_Employe(E);
		if E.NomE=TE.Employe.NomE and E.PrenomE=TE.Employe.PrenomE and E.Profession=TE.Employe.Profession then			
        	FT_t_Employe.tete := FT_t_Employe.tete.suiv;
		else
      		while TE.suiv.employe.nomE /= E.nomE loop
    			TE := TE.suiv;
			end loop;
     		if TE.suiv.employe.Disponible = False then 
        		Put("Cet employe est en audit"); new_line;
    		else
           		TE.suiv := TE.suiv.suiv;
      		end if;
		end if;
end Depart;

---------------------------------------------------------------------------------------  
         
Procedure Affiche_Employe (L: in out T_Liste_Employe; dateDuJour : T_Date) is
	bool:boolean;
	Begin
		if L /= null then
			put("Nom : "); put(L.Employe.NomE); new_line; 
			put("Prenom : "); put(L.Employe.PrenomE); new_line;
			put("Profession : ");
			if L.Employe.Profession then
				put_line("Technicien");
			else
				put_line("Ingenieur");
			end if;
			put("Conge : ");
			bool:=Compare_T_Date(L.Employe.Retour, dateDuJour);
			if bool=false then
				put("Non");new_line; 
			else
				put("Retour le");
				put(L.Employe.Retour.jour); put("/"); 
				put(L.Employe.Retour.mois); put("/");
				put(L.Employe.Retour.annee); new_line; 
			end if;
			put("Disponibe : ");
			if L.Employe.Disponible=true then
				put("Oui"); new_line;
			else
				put("Non"); new_line;
			end if;
			put("Nombre d audit : ");
			put(L.Employe.Nb_audit); new_line;
			put("Nombre de jours en audit : ");
			put(L.Employe.Nb_jours_audit);
			new_line;
			Affiche_Employe(L.suiv, dateDuJour);			
		end if;
End Affiche_Employe;

---------------------------------------------------------------------------------------  
       
Procedure Depart_Conges(L: in out T_Liste_Employe; dateDuJour : T_Date) is
	Procedure esclave(L: in out T_Liste_Employe; E: T_Employe; dateRetour : T_Date) is
		Begin
			if L=NULL then
				put("Employe indisponible, la prise de conges est impossible"); new_line;
			else
				if L.Employe.NomE=E.NomE and L.Employe.prenomE=E.prenomE and L.Employe.Disponible then
					L.Employe.Retour:=dateRetour;
					put("Depart en conge de l employe: "); put(L.Employe.NomE); put(L.Employe.prenomE); new_line;
				else
					esclave(L.suiv, E, dateRetour);
				end if;
			end if;
	end esclave;
	bool:boolean;
	E: T_Employe;
	dateRetour: T_Date;
	Begin
		Saisie_Employe(E);
		put_line("Saisir la date du retour de l'employe");
		loop
			Saisie_T_Date(dateRetour);
			bool:=Compare_T_Date(dateRetour, dateDuJour);
			exit when bool;
			put("La date du retour est inferieure ou egale à la date du jour, ressaisissez..");
		end loop;
		esclave(L, E, dateRetour);
end Depart_Conges;

---------------------------------------------------------------------------------------  

Function employe_disponible(E, noob: T_Liste_Employe; Profession: boolean; dateDuJour: T_Date) return T_Liste_Employe is 
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
					return employe_disponible(E.suiv, E, Profession, dateDuJour);
				end if;
			end if;
		return employe_disponible(E.suiv, noob, Profession, dateDuJour);
		end if;
end employe_disponible;
end employe;














