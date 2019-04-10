with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, archivage;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, archivage;

package body audit is
	
	
	Function Compare_NumeroAudit(F: T_File_Demande; Numero: Integer) return boolean is
	Begin
		if F/= NULL then
			if F.Demande_Audit.Numero=Numero then
				return false;
			else
				return Compare_NumeroAudit(F.suiv, Numero);
			end if;
		else
			return true;
		end if;
	end Compare_NumeroAudit;
	
-------------------------------------------------------------------------------------------- 
	
Procedure Saisie_Demande_Audit (DA: in out T_Demande_Audit; dateDuJour : in T_Date; LTete : in out T_tete_Liste_Entreprise) is
	option: integer;
	bool: boolean;
	Begin
		put_line("Saisie nouvel audit:");
		put("Saisir l'id de l'audit : ");
		get(DA.Numero); skip_line; new_line;
		loop
			put("Date de debut au plus tot :");
			Saisie_T_Date(DA.DateAuPlusTot); new_line;
			bool:=Compare_T_Date(dateDuJour, DA.DateAuPlusTot);
			exit when bool=false;
			put("Date saisie remplacee par date du jour"); new_line;
			DA.DateAuPlusTot:=dateDuJour;
			exit;
		end loop;
		put("Saisir la duree de l'audit :");
		get(DA.Duree); skip_line; new_line;
		put("1 => Urgence"); new_line;
		put("2 => Routine: ");new_line;
		loop
			get(option); skip_line;
			case option is
				when 1 => DA.Urgence:=true; exit;
				when 2 => DA.Urgence:=false; exit;
				when others => put("Votre saisie est erronee, ressaisissez..");
			end case;
		end loop;
		put("Saisir l entreprise concernee par l audit: ");
		Saisie_T_Mot(DA.Entreprise);
		bool:=false;
		bool:=Compare_entreprise(LTete.tete, DA.Entreprise);
		if bool then
			put("L entreprise saisie n existe pas, veuillez l'ajouter"); new_line;
			Ajout_Entreprise(LTete);
		end if;
		Saisie_Nature(DA.Nature);
		DA.Profession:=Saisie_Profession;
end Saisie_Demande_Audit;

-------------------------------------------------------------------------------------------- 
		
Procedure Insertion_Liste_Demande (Urgence, Routine: in out T_TF_File_Demande; dateDuJour : in T_Date; LTete : in out T_tete_Liste_Entreprise) is
	DA: T_Demande_Audit;
	Begin
		Saisie_Demande_Audit(DA, dateDuJour, LTete);
		if Da.Urgence then
			Insertion_Urgence(Urgence, DA);
		else
			Insertion_Routine(Routine, DA);
		end if;
end Insertion_Liste_Demande;

-------------------------------------------------------------------------------------------- 

Procedure Insertion_Urgence(Urgence: in out T_TF_File_Demande; DA: in T_Demande_Audit) is 
U:T_File_Demande;
val:boolean;
	Begin
		U:=Urgence.tete;
		if Urgence.tete=NULL then
			Urgence.tete := new T_UneFile_Demande'(DA,NULL);
			Urgence.fin := Urgence.tete;
		elsif Urgence.tete.Demande_Audit.Duree>DA.Duree then
			Urgence.tete:= new T_UneFile_Demande'(DA,Urgence.tete);
		else	
			while U/=Null loop
				if U.Demande_Audit.Duree>DA.Duree then
					U:= new T_UneFile_Demande'(DA,U);
					val:=true;
					U:=U.suiv;
				else
					U:=U.suiv;
				end if;
			end loop;
			if U=NULL and val=false then
				Urgence.fin.suiv:=new T_UneFile_Demande'(DA,NULL);
			end if;	
		end if;		
end Insertion_Urgence;	

-------------------------------------------------------------------------------------------- 

Procedure Insertion_Routine (Routine: in out T_TF_File_Demande; DA: in T_Demande_Audit) is 
Begin
	if Routine.tete=NULL then
		Routine.tete := new T_UneFile_Demande'(DA,NULL);
		Routine.fin := Routine.tete;
	else
		Routine.fin.suiv := new T_UneFile_Demande'(DA,NULL);
		Routine.fin := Routine.fin.suiv;
	end if;
end Insertion_Routine;

-------------------------------------------------------------------------------------------- 

Procedure Supprime_Urgence_demande_audit (Urgence: in out T_TF_File_Demande; Numero: in integer) is
	TD:T_File_Demande;
	Begin
   		TD := Urgence.tete ;		
		if Numero=TD.Demande_Audit.Numero then			
        	Urgence.tete := Urgence.tete.suiv;
		else
      		while Numero /= TD.Demande_Audit.Numero loop
    			TD := TD.suiv;
			end loop;
			if Urgence.fin = TD.suiv then
				Urgence.fin:=TD;
				Urgence.fin.suiv:=NULL;
			else
           	TD.suiv := TD.suiv.suiv;
			end if;
		end if;
end Supprime_Urgence_demande_audit;

-------------------------------------------------------------------------------------------- 

Procedure Supprime_Routine_demande_audit (Routine: in out T_TF_File_Demande; Numero: in integer) is
	TD:T_File_Demande;
	Begin
   		TD := Routine.tete ;		
		if Numero=TD.Demande_Audit.Numero then			
        	Routine.tete := Routine.tete.suiv;
		else
      		while Numero /= TD.Demande_Audit.Numero loop
    			TD := TD.suiv;
			end loop;
			if Routine.fin = TD.suiv then
				Routine.fin:=TD;
				Routine.fin.suiv:=NULL;
			else
           	TD.suiv := TD.suiv.suiv;
			end if;
		end if;
end Supprime_Routine_demande_audit;

-------------------------------------------------------------------------------------------- 
				
Procedure Affiche_liste_audit (File: in out T_File_Demande) is
	Begin
		if File/=NULL then	
			put("Demande n "); put(File.Demande_Audit.Numero,4); new_line;
			put("Date au plus tot :");
			put(File.Demande_Audit.DateAuPlusTot.jour,2); put("/");
			put(File.Demande_Audit.DateAuPlusTot.mois,2); put("/");
			put(File.Demande_Audit.DateAuPlusTot.annee,4); new_line;  
			put("Duree necessaire:"); put(File.Demande_Audit.Duree,4); new_line;
			if File.Demande_Audit.Urgence then
				put("Urgence"); new_line;
			else
				put("Routine"); new_line;
			end if;
			put("Entreprise : ");
			put(File.Demande_Audit.Entreprise); new_line;
			put("Nature : "); put(T_Nature'image(File.Demande_Audit.Nature)); new_line;
			put("Professionnel qualifie: ");
			if File.Demande_Audit.Profession then
				put("Technicien");
			else
				put("Ingenieur");
			end if; new_line;
			Affiche_liste_audit(File.suiv); new_line;			
		end if;	
end Affiche_liste_audit;
	
-------------------------------------------------------------------------------------------- 
	
Procedure Insertion_liste_audit_en_cours (Urgence, Routine: in out T_TF_File_Demande; dateDuJour: in T_Date; EnCours: in out T_TF_Liste_Audit; LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise) is
	Procedure Insertion_liste (AD: in T_File_Demande; TF: in T_TF_File_Demande; dateDuJour: in T_Date; EnCours: in out T_TF_Liste_Audit;  LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise) is 
		bool: boolean;
		Lemploye: T_Liste_Employe;
		Lekit: T_Liste_Kit;
		AeC: T_Audit_en_cours;
		Begin
			if AD /= NULL then
				bool:=Compare_T_Date(AD.Demande_Audit.DateAuPlusTot, dateDuJour);
				if bool=false then
					Lemploye:=LEtete.tete;
					Lekit:=LKtete.tete;
					Lemploye:=employe_disponible(LEtete.tete, Lemploye, AD.Demande_Audit.Profession, dateDuJour);
					Lekit:=kit_disponible(LKtete.tete, Lekit, AD.Demande_Audit.Nature);
					
					if Lemploye/=NULL and Lekit/=NULL then
						put("Debut de l'audit numero:");put(AD.Demande_Audit.Numero,4);new_line;						
						AeC.NumeroA:= AD.Demande_Audit.Numero;
						AeC.Date_debut:= dateDuJour;
						AeC.Duree:= AD.Demande_Audit.Duree;
						AeC.Date_fin:= retourne_date(dateDuJour, AeC.Duree);
						AeC.Kit:= Lekit;
						Aec.Employe:= Lemploye;
						Aec.Entreprise:= recherche_pteur_ent(LEntete.tete, AD.Demande_Audit.Entreprise);
						Aec.Reporte:=AD.Demande_Audit.Reporte;
						
						Aec.Kit.Kit.Nb_utilisation:=Lekit.Kit.Nb_utilisation+1;
						Aec.Kit.Kit.Utilise:=true;
						Aec.Employe.Employe.Disponible:=false;
						
						Ajout_en_cours(AeC, EnCours);
						
						if AD.Demande_Audit.Urgence then
							Supprime_Urgence_demande_audit(Urgence, AD.Demande_Audit.Numero);
						else
							Supprime_Routine_demande_audit(Urgence, AD.Demande_Audit.Numero);
						end if;
					end if;
				end if;
				Insertion_liste(AD.suiv, TF, dateDuJour, EnCours, LEtete, LKtete, LEntete);
			end if;				
	end Insertion_liste;
	Begin
		Insertion_liste(Urgence.tete, Urgence, dateDuJour, EnCours, LEtete, LKtete, LEntete);
		Insertion_liste(Routine.tete, Routine, dateDuJour, EnCours, LEtete, LKtete, LEntete);		
end Insertion_liste_audit_en_cours;	
							
-------------------------------------------------------------------------------------------- 

Procedure Ajout_en_cours(AeC: in T_Audit_en_cours; EnCours: in out T_TF_Liste_Audit) is 
A:T_Liste_Audit;
bool, val:boolean:=false;
	Begin
		A:=EnCours.tete;
		if A/=Null then
			bool:=Compare_T_Date(EnCours.tete.audit.date_fin, AeC.date_fin);
		else
			EnCours.tete := new T_UnAudit'(AeC,NULL);
		end if;
		if bool then
			EnCours.tete:= new T_UnAudit'(AeC,EnCours.tete.suiv);
		else	
			while A/=Null loop
				if bool then
					A:= new T_UnAudit'(AeC,A);
					val:=true;
					A:=A.suiv;
				else
					A:=A.suiv;
				end if;
			end loop;
			if A=NULL and val=false then
				A:=new T_UnAudit'(AeC,NULL);
			end if;	
		end if;		
end Ajout_en_cours;	

-------------------------------------------------------------------------------------------- 
		
Procedure Affiche_audit_en_cours (L: in out T_Liste_Audit) is
	Begin
		if L/=NULL then	
			put("Demande n "); put(L.Audit.NumeroA); new_line;
			put("Date de debut:");
			put(L.Audit.Date_debut.jour); put("/");
			put(L.Audit.Date_debut.mois); put("/");
			put(L.Audit.Date_debut.annee); new_line; 
			put("Date de fin:");
			put(L.Audit.Date_fin.jour); put("/");
			put(L.Audit.Date_fin.mois); put("/");
			put(L.Audit.Date_fin.annee); new_line;  
			put("Duree necessaire : "); put(L.Audit.Duree); new_line;
			put("Numero du Kit : "); put(L.Audit.Kit.Kit.Identifiant); new_line;
			put("Employe : "); put(L.Audit.Employe.Employe.NomE);put(L.Audit.Employe.Employe.PrenomE); new_line;
			put("Entreprise : "); put(L.Audit.Entreprise.Entreprise.Nom); new_line;	
			
			Affiche_audit_en_cours (L.suiv);
		end if;	
end Affiche_audit_en_cours;

-------------------------------------------------------------------------------------------- 

Procedure Supprime_en_cours(EnCours: in out T_TF_Liste_Audit; NumeroA: in integer) is
	TA:T_Liste_Audit;
	Begin
   		TA := EnCours.tete;
		if TA/=NULL then
			if NumeroA=TA.Audit.NumeroA then		
        		EnCours.tete := EnCours.tete.suiv;
			else
      			while TA.suiv.Audit.NumeroA /= NumeroA loop
    				TA := TA.suiv;
				end loop;
				if TA.suiv.Audit.NumeroA /= NumeroA then
					TA.suiv := TA.suiv.suiv;
				end if;
			end if;
		end if;
end Supprime_en_cours;

-------------------------------------------------------------------------------------------- 

Procedure Actualisation(EnCours: in out T_TF_Liste_Audit; Routine: in out T_TF_File_Demande; A_EnCours: in out T_Liste_Audit; dateDuJour: in T_Date) is	
	Procedure Sortie (EnCours: in out T_TF_Liste_Audit; A_EnCours: in out T_Liste_Audit; dateDuJour: in T_Date; R : in T_Resultat) is
		historique:T_Audit_Historique;
		Begin
			historique.Numero:=A_EnCours.Audit.NumeroA;
			historique.Date_fin:=dateDuJour;
			historique.Duree:=A_EnCours.Audit.Duree;
			historique.nature_kit:=A_EnCours.Audit.Kit.Kit.Nature;
			historique.id_Kit:=A_EnCours.Audit.Kit.Kit.Identifiant;
			historique.Employe_nom:=A_EnCours.Audit.Employe.Employe.NomE;
			historique.Employe_prenom:=A_EnCours.Audit.Employe.Employe.prenomE;
			
			put("Suppression de : "); put(A_EnCours.Audit.NumeroA); new_line;			
			Supprime_en_cours(EnCours, A_EnCours.Audit.NumeroA);
			
--			Archivage_Audit_en_cours(T_Audit_Historique);
	end Sortie;
		
	DA: T_Demande_Audit;
	option: integer;
	bool:boolean;
	Resultat:T_Resultat;
	Begin
		if A_EnCours/=NULL then
			bool:=Compare_T_Date(A_EnCours.Audit.Date_fin, dateDuJour);
			if bool then
				A_EnCours.Audit.Employe.Employe.Nb_jours_audit:=A_EnCours.Audit.Employe.Employe.Nb_jours_audit+1;
			else
				A_EnCours.Audit.Employe.Employe.Nb_jours_audit := A_EnCours.Audit.Employe.Employe.Nb_jours_audit+1;
				A_EnCours.Audit.Employe.Employe.Nb_audit := A_EnCours.Audit.Employe.Employe.Nb_audit+1;
				A_EnCours.Audit.Employe.Employe.Disponible:=true;
				A_EnCours.Audit.Kit.Kit.Utilise:=false;
				A_EnCours.Audit.Entreprise.Entreprise.Date_dernier_audit:=dateDuJour;

				if A_EnCours.Audit.Reporte=false then
					put("Resultat de l'audit de l'entreprise : ");
					put(A_EnCours.Audit.Entreprise.Entreprise.Nom); new_line;
					put_line("Tapez 1 pour positif");
					put_line("Tapez 2 pour negatif");
					put_line("Tapez 3 pour problematique");
					loop
						get(option); skip_line;
						case option is						
							when 1 => Resultat:=positif; Sortie(EnCours, A_EnCours, dateDuJour, Resultat); exit;
							when 2 => Resultat:=negatif; Sortie(EnCours, A_EnCours, dateDuJour, Resultat); exit;
							when 3 => Resultat:=problematique;
							
							DA.Numero:=A_EnCours.Audit.NumeroA;
							DA.DateAuPlusTot:=retourne_date(dateDuJour, 30);
							DA.Duree:=A_EnCours.Audit.Duree;
							DA.Urgence:=false;
							DA.Entreprise:=A_EnCours.Audit.Entreprise.Entreprise.Nom;
							DA.Nature:=A_EnCours.Audit.Kit.Kit.Nature;
							DA.Profession:=A_EnCours.Audit.Employe.Employe.Profession;
							DA.Reporte:=true;
				
							Insertion_Routine (Routine, DA);
							Sortie(EnCours, A_EnCours, dateDuJour, Resultat); exit;
							when others => put("Erreur saisie, ressaisissez..");
						end case;
					end loop;
				else
					put("Resultat de l'audit de l'entreprise : ");
					put(A_EnCours.Audit.Entreprise.Entreprise.Nom); new_line;
					put_line("Tapez 1 pour positif");
					put_line("Tapez 2 pour negatif");
					put_line("L'option problematique indisponible");
					loop
						get(option); skip_line;
						case option is
							when 1 => Resultat:=positif;
							Sortie(EnCours, A_EnCours, dateDuJour, Resultat); exit;
							when 2 => Resultat:=negatif;
							Sortie(EnCours, A_EnCours, dateDuJour, Resultat); exit;
							when others => put("Erreur saisie, ressaisissez..");
						end case;
					end loop;
				end if;
				
			end if;
			Actualisation(EnCours, Routine, A_EnCours.suiv, dateDuJour);
		end if;
end Actualisation;

end audit;



























