with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;
use  Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, employe, kit, entreprise, audit;

package body archivage is

	Procedure Passage_au_lendemain(dateDuJour: in out T_Date) is 
		Begin	
			dateDuJour:=retourne_date(dateDuJour, 1);
			KitPerime(dateDuJour, LKtete);
			Insertion_liste_audit_en_cours(Urgence, Routine, dateDuJour, EnCours, LEtete, LKtete, LEntete);
			
			
			
			
			
			
			
	end Passage_au_lendemain;

end archivage;