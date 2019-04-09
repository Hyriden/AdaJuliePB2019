with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit, ada.Sequential_io;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;

Package archivage is

	Procedure Passage_au_lendemain(EnCours: in out T_TF_Liste_Audit; Urgence, Routine: in out T_TF_File_Demande; LEtete: in out T_tete_Liste_Employe; LKtete: in out T_tete_Liste_Kit; LEntete: in out T_tete_Liste_Entreprise; dateDuJour: in out T_Date);
	-- appel les fonction d'actualisation , kit perime et insertion liste en cours
	Function retourne_date(date: T_date; nbj: integer) return T_Date;
	--retourne la date + ou - un nombre de jours
	
	--Procedure Archivage_Audit_en_cours(histo: in T_Audit_Historique); -- archive les historiques


end archivage;








