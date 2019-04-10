with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, ada.characters.handling, kit, employe, entreprise, audit, archivage;

Procedure main_project is	

--n,3,2,0
option: integer;
choix: character;
EnCours: T_TF_Liste_Audit;
Urgence, Routine: T_TF_File_Demande;
LEtete: T_tete_Liste_Employe; 
LKtete: T_tete_Liste_Kit; 
LEntete: T_tete_Liste_Entreprise; 
dateDuJour: T_Date;
	
Procedure Lancement (LEtete : in out T_tete_Liste_Employe;
LKtete: in out T_tete_Liste_Kit;
LEntete: in out T_tete_Liste_Entreprise;
EnCours: in out T_TF_Liste_Audit;
Urgence, Routine: in out T_TF_File_Demande;
dateDuJour: in out T_Date) is
	
	Employe:T_Employe;
	Kit:T_Kit;
	Audit:T_Demande_Audit;
	Entreprise:T_entreprise;
	Auditencours:T_Audit_en_cours;
	
Begin
	dateDuJour:=(10,04,2019);
	
    Employe.NomE := "Trouvetout"&(11..30=>' ');
    Employe.PrenomE := "Marc"&(5..30=>' ');
    Employe.Profession := False;
    LEtete.tete:=new T_UnEmploye'(Employe,LEtete.tete);
   
    Employe.NomE := "Autop"&(6..30=>' ');
    Employe.PrenomE := "Juliette"&(9..30=>' ');
    Employe.Profession := False;
    LEtete.tete:=new T_UnEmploye'(Employe,LEtete.tete);
   
    Employe.NomE := "Sansoucis"&(10..30=>' ');
    Employe.PrenomE := "Marie"&(6..30=>' ');
    Employe.Profession := True;
    Employe.Disponible := False;
    Employe.Nb_jours_audit := 7;
    Employe.Nb_audit:= 1 ;  
    LEtete.tete:=new T_UnEmploye'(Employe,LEtete.tete);
   
    Employe.NomE := "Toutvabien"&(11..30=>' ');
    Employe.PrenomE := "Lucette"&(8..30=>' ');
    Employe.Profession := True;
    Employe.Retour:= retourne_date(dateDuJour,3);
    Employe.Disponible := True;
    Employe.Nb_jours_audit := 8;
    Employe.Nb_audit:= 1 ;  
    LEtete.tete:=new T_UnEmploye'(Employe,LEtete.tete);
   
    Employe.NomE := "Tropfort"&(9..30=>' ');
    Employe.PrenomE := "Greg"&(5..30=>' ');
    Employe.Retour:= dateDuJour; 
    Employe.Disponible := False;
    Employe.Profession := True;
    Employe.Nb_jours_audit := 12;
    Employe.Nb_audit:= 3 ;  
    LEtete.tete:=new T_UnEmploye'(Employe,LEtete.tete);


    Kit.Identifiant := 2014;
    Kit.Nature := t_nature'value("Veterinaire");
    Kit.Nb_utilisation := 1;
    Kit.Date_peremption := retourne_date(dateDuJour,3);
    LKtete.tete:=new T_UnKit'(Kit,LKtete.tete);
   
    Kit.Identifiant := 21412;
    Kit.Nature := t_nature'value("Veterinaire");
    Kit.Nb_utilisation := 0;
    Kit.Date_peremption := retourne_date(dateDuJour,365);
    LKtete.tete:=new T_UnKit'(Kit,LKtete.tete);
   
    Kit.Identifiant := 1917;
    Kit.Nature := T_Nature'value("Phyto_sanitaire");
    Kit.Nb_utilisation := 2;
    Kit.Date_peremption := retourne_date(dateDuJour,730);
	Kit.Utilise:= true ;
    LKtete.tete:=new T_UnKit'(Kit,LKtete.tete);
   
    Kit.Identifiant := 21328;
    Kit.Nature := T_Nature'value("Microbiologie");
    Kit.Nb_utilisation := 2;
    Kit.Date_peremption := retourne_date(dateDuJour,60);
	Kit.Utilise:= true ;	
    LKtete.tete:=new T_UnKit'(Kit,LKtete.tete);
   
    Audit.Numero := 11;
    Audit.Duree := 2;
    Audit.DateAuPlusTot := retourne_date(dateDuJour,-2);
    Audit.Profession := False;
    Audit.Entreprise := "MANGETOUT"&(10..30=>' ');
    Audit.Nature := T_Nature'Value("Analyse_Composition");
    Insertion_Urgence(Urgence, Audit);   
	
    Audit.Numero := 12;
    Audit.Duree := 2;
    Audit.DateAuPlusTot := dateDuJour;
    Audit.Profession := false;
    Audit.Entreprise := "BELLES VACHES"&(14..30=>' ');
    Audit.Nature := T_Nature'Value("Veterinaire");
    Insertion_Urgence(Urgence, Audit);   
   
    Audit.Numero := 13;
    Audit.Duree := 4;
    Audit.DateAuPlusTot := retourne_date(dateDuJour,-1);
    Audit.Profession := false;
    Audit.Entreprise := "MES PETITS LEGUMES"&(19..30=>' ');
    Audit.Nature := T_Nature'Value("Phyto_sanitaire");
    Insertion_Urgence(Urgence, Audit);   
   
    Audit.Numero := 8;
    Audit.Duree := 5;
    Audit.DateAuPlusTot := retourne_date(dateDuJour,-3);
    Audit.Profession := false;
    Audit.Entreprise := "SOIGNE TOUT"&(12..30=>' ');
    Audit.Nature := T_Nature'Value("Microbiologie");
    Insertion_Routine(Routine, Audit);   
   
    Audit.Numero := 9;
    Audit.Duree := 2;
    Audit.DateAuPlusTot := retourne_date(dateDuJour,-2);
    Audit.Profession := true;
    Audit.Entreprise := "JOLIS POULETS"&(14..30=>' ');
    Audit.Nature := T_Nature'Value("Veterinaire");
    Insertion_Routine(Routine, Audit);   
   
    Audit.Numero := 10;
    Audit.Duree := 1;
    Audit.DateAuPlusTot := retourne_date(dateDuJour,-2);
    Audit.Profession := true;
    Audit.Entreprise := "TOUTVERT"&(9..30=>' ');
    Audit.Nature := T_Nature'Value("Phyto_sanitaire");
    Insertion_Routine(Routine, Audit);   
   
    Entreprise.nom := "JECULTIVE"&(10..30=>' ');
    Entreprise.Date_dernier_audit := retourne_date(dateDuJour,-31);
    Entreprise.Resulat_Dernier_Audit := Problematique;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "BELLES VACHES"&(14..30=>' ');
    Entreprise.Date_dernier_audit := (1,1,0); 
    Entreprise.Resulat_dernier_audit := Sans_audit;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "MES PETITS LEGUMES"&(19..30=>' ');
    Entreprise.Date_dernier_audit := (1,1,0); -- PAS DE DERNIER AUDIT
    Entreprise.Resulat_dernier_audit := Sans_audit;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "MANGE TOUT"&(11..30=>' ');
    Entreprise.Date_dernier_audit := (1,1,0); -- PAS DE DERNIER AUDIT
    Entreprise.Resulat_dernier_audit := Sans_audit;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "PETITS CHIENS"&(14..30=>' ');
    Entreprise.Date_dernier_audit := (12,10,2016);
    Entreprise.Resulat_dernier_audit := Positif;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "SOIGNE TOUT"&(12..30=>' ');
    Entreprise.Date_dernier_audit := (22,12,2018);
    Entreprise.Resulat_dernier_audit := Positif;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "SUPERMEDOC"&(11..30=>' ');
    Entreprise.Date_dernier_audit := (15,6,2018);
    Entreprise.Resulat_dernier_audit := Positif;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "TOUTVERT"&(9..30=>' ');
    Entreprise.Date_dernier_audit := (10,4,2017);
    Entreprise.Resulat_dernier_audit := Negatif;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "BELLES VACHES"&(14..30=>' ');
    Entreprise.Date_dernier_audit := (1,1,0); 
    Entreprise.Resulat_dernier_audit := Sans_audit;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   
    Entreprise.nom := "JOLIS POULETS"&(14..30=>' ');
    Entreprise.Date_dernier_audit := (1,1,0); 
    Entreprise.Resulat_dernier_audit := Sans_audit;
    LEntete.tete:=new T_UneEntreprise'(Entreprise,LEntete.tete);
   

    Auditencours.NumeroA := 6;
    Auditencours.Date_debut := retourne_date(dateDuJour,-4);
    Auditencours.Date_fin := retourne_date(dateDuJour,1);
    Auditencours.Duree := 6;
    Auditencours.Employe := recherche_pteur_emp(LEtete.tete,"Tropfort"&(9..30=>' '));
    Auditencours.Kit := Recherche_Pteur_Kit_Id(LKtete.tete,21328);
    Auditencours.entreprise := Recherche_Pteur_Ent(LEntete.tete,"SUPERMEDOC"&(11..30=>' '));
    Ajout_en_cours(Auditencours,EnCours);
   
    Auditencours.NumeroA := 7;
    Auditencours.Date_debut := retourne_date(dateDuJour,-4);
    Auditencours.Date_fin := retourne_date(dateDuJour,5);
    Auditencours.Duree := 5;
    Auditencours.Reporte := True;
    Auditencours.Employe := recherche_pteur_emp(LEtete.tete,"Sansoucis"&(10..30=>' '));
    Auditencours.Kit := Recherche_Pteur_Kit_Id(LKtete.tete,1917);
    Auditencours.entreprise := Recherche_Pteur_Ent(LEntete.tete,"JECULTIVE"&(10..30=>' '));
    Ajout_en_cours(Auditencours,EnCours);
end Lancement;

	Procedure Menu(choix:out character) is
		Begin
			loop
				new_line;
				new_line;
				new_line;
		--		put_line("    ╔╦╗┌─┐┌┐┌┬ ┬");
		--		put_line("    ║║║├┤ ││││ │");
		--		put_line("    ╩ ╩└─┘┘└┘└─┘");

				
				Put_Line("Bienvenue dans le menu, veuillez taper sur un des chiffres suivants");
				New_Line;
				Put_Line("0 => Saisie date du jour");
				Put_Line("1 => Gerer les employes");
				Put_Line("2 => Gerer les kits");
				Put_Line("3 => Gerer les entreprises");
				Put_Line("4 => Gerer les audits");
				Put_Line("5 => Gerer l'archivage");
				Put_Line("6 => Lendemain");
				Put_Line("7 => QUITTER..");
				Put(" Choix :");
				Get(Choix);
				Skip_Line;
				exit when Choix='0' or Choix='1' or Choix='2' or Choix='3' or Choix='4' or Choix='5' or Choix='6' or Choix='7';
				Put("Erreur saisie"); new_line;
				end loop;
	end Menu;
		Begin
			Lancement(LEtete, LKtete, LEntete, EnCours, Urgence, Routine, dateDuJour);
			loop
				Menu(Choix);
				case Choix is
					when '0' => Saisie_T_Date(dateDuJour);
						put("Nous somme le:"); 
						put(dateDuJour.jour);put("/"); 
						put(dateDuJour.mois);put("/"); 
						put(dateDuJour.annee); new_line;					
					when '1' => Put_Line("Bienvenue dans la partie gestion des employes");
				    	loop
				    		Put_Line("a => Recrutement d'un employe");
				    		Put_Line("b => Supression d'un employe");
				    		Put_Line("c => Affichage de tous les employes");
				    		Put_Line("d => Depart en conge d'un employes");
				    		Put_Line("e => QUITTER..");
				    		Put(" Choix :");
				    		Get(Choix);
				    		Skip_Line;
				    		exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e' ;
				    		Put("Erreur saisie"); new_line;
				   	 	end loop;
						case Choix is
							when 'a' => recrutement(LEtete.tete);
							when 'b' => Depart(LEtete);
							when 'c' => Affiche_Employe(LEtete.tete, dateDuJour);
							when 'd' => Depart_Conges(LEtete.tete, dateDuJour);
							when 'e' => NULL;
							when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");
						end case;

				   when '2' => Put_Line("Bienvenue dans la partie gestion des kits");
				            loop
				               Put_Line("a => Ajouter un kit");
				               Put_Line("b => Supression un kit");
				               Put_Line("c => Affichage de tous les kits");
				               Put_Line("d => QUITTER..");
				               Put(" Choix :");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d';
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Ajout_Kit(LKtete, dateDuJour);
				               when 'b' => Suppr_Kit (LKtete);
				               when 'c' => Affiche_Kit (LKtete.tete);
				               when 'd' => NULL;
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;                                                                                
				            end case;

				         when '3' => Put_Line("Bienvenue dans la partie gestion des entreprises");
				            loop
				               Put_Line("a => Ajouter une entreprise");
				               Put_Line("b => Affichage de tous les entreprises");						   
				               Put_Line("c => QUITTER..");
				               Put(" Choix :");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' ;
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Ajout_Entreprise(LEntete);
							   when 'b' => Affiche_Entreprise (LEntete.tete);
				               when 'c' => NULL; 
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;                                                                                
				            end case;
							

				         when '4' => Put_Line("Bienvenue dans la partie gestion des audits");
				            loop
				               Put_Line("a => Faire une demande d'audits");     
				               Put_Line("b => Afficher la liste des demandes d'Urgences");  
				               Put_Line("c => Afficher la liste des demandes de Routines");
				               Put_Line("d => Afficher les audits en cours");                                    
				               Put_Line("e => QUITTER..");
				               Put("Choix : ");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c' or Choix='d' or Choix='e';
				               Put("Erreur saisie"); new_line;
				            end loop;
				            case Choix is
				               when 'a' => Insertion_Liste_Demande (Urgence, Routine, dateDuJour, LEntete);
				               when 'b' => Affiche_liste_audit (Urgence.tete);
				               when 'c' => Affiche_liste_audit (Routine.tete);
				               when 'd' => Affiche_audit_en_cours (EnCours.tete);
				               when 'e' => NULL;
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");                                                                                
				            end case;
         
				         when '5' => Put_Line("Bienvenue dans la partie gestion des archives");
				            loop
				               Put_Line("a => Telecharger les archives");
				               Put_Line("b => Afficher audit termines");
				               Put_line("c => QUITTER..");
				               Put("Choix");
				               Get(Choix);
				               Skip_Line;
				               exit when Choix='a' or Choix='b' or Choix='c';
				               Put_Line("Erreur saisie"); new_line;
				            end loop;
				            case Choix is 
				               when 'a' => NULL; --Telecharger_Archive;
				               when 'b' => NULL; 
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU");
				            end case;
   				         when '6' => Put_Line("Passage au lendemain");
			            	loop
			            		Put_Line("a => 1 jour");
			            		Put_Line("b => x jours");
			               	  	Put_line("c => QUITTER..");
								Put("Choix :");
			               		Get(Choix);
			               	 	Skip_Line;
			               	 	exit when Choix='a' or Choix='b' or Choix='c';
			               	 	Put_Line("Erreur saisie"); new_line;
			            	end loop;
				            case Choix is 
				               when 'a' => Passage_au_lendemain(EnCours, Urgence, Routine, LEtete, LKtete, LEntete, dateDuJour);
				               when 'b' => put("Saisie nombre de jours a passer :"); get(option); skip_line;
							   		for i in 1..option loop
										Passage_au_lendemain(EnCours, Urgence, Routine, LEtete, LKtete, LEntete, dateDuJour);
									end loop;
				               when 'c' => NULL;  
							   when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;
				            end case;
						 when '7' => exit;
						 when others => put ("C'EST IMPOSSIBLE -> problème dans procedure MENU"); new_line;				
				      end case;
				   end loop;            
				
end main_project;