with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise;

Package audit is

	Subtype T_Duree is integer range 1..10;
	Type T_Demande_Audit is record 
		Numero : integer ;
		DateAuPlusTot : T_Date ;
		Duree : T_Duree ;
		Urgence : boolean ; 
		Entreprise : T_Mot ;
		Nature : T_Nature ;
		Profession : boolean; 
	end record ;
	
	Type T_UneFile_Demande ;
	Type T_File_Demande is access T_UneFile_Demande ; 
	Type T_UneFile_Demande is record
		Demande_Audit : T_Demande_Audit ;
		Suiv : T_File_Demande ; 
	end record ;
	
	Type T_TF_File_Demande is record 
		tete,fin:T_File_Demande;
	end record;
	
	Type T_Audit_en_cours is record 
		NumeroA : integer ;
		Date_debut : T_Date ;
		Date_fin : T_Date ;
		Duree : T_Duree ;
		Kit : T_Liste_Kit ;
		Employe : T_Liste_Employe ; 
		Entreprise : T_Liste_Entreprise ;
	end record ;
	
	Type T_UnAudit;
	Type T_Liste_Audit is access T_UnAudit ; 
	Type T_UnAudit is record
		Audit : T_Audit_en_cours ;
		suiv : T_Liste_Audit ; 
	end record;
	
	Type T_TF_Liste_Audit is record 
		tete: T_Liste_Audit;
	end record;
	
	
	--procedure 
	
	Function Compare_NumeroAudit(F:T_File_Demande; Numero: Integer) return boolean;
	Procedure Saisie_Demande_Audit (DA: in out T_Demande_Audit; dateDuJour : in T_Date);
	Procedure Insertion_Liste_Demande (Urgence, Routine: in out T_TF_File_Demande; dateDuJour : in T_Date);
	Procedure Supprime_Urgence_demande_audit (Urgence: in out T_TF_File_Demande; Numero: in integer);
	Procedure Supprime_Routine_demande_audit (Routine: in out T_TF_File_Demande; Numero: in integer);	
	Procedure Affiche_liste_audit (File: in out T_File_Demande);
	Procedure Insertion_liste_audit_en_cours (Urgence, Routine: in out T_TF_File_Demande; dateDuJour: in T_Date; EnCours: in out T_TF_Liste_Audit; LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise);
	Procedure Ajout_en_cours(AeC: in T_Audit_en_cours; EnCours: in out T_TF_Liste_Audit);
	Procedure Affiche_audit_en_cours (L: in out T_Liste_Audit);
	
	
end audit;

















