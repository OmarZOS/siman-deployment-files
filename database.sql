-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Archive
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Archive
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Archive` ;
USE `Archive` ;

-- -----------------------------------------------------
-- Table `Archive`.`domain_organisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`domain_organisation` (
  `idDomain_Organisation` INT NOT NULL AUTO_INCREMENT,
  `Domain_Organisation_label_fr` VARCHAR(45) NULL,
  `Domain_Organisation_label_ar` VARCHAR(45) NULL,
  `Domain_Organisation_acronym_fr` VARCHAR(45) NULL,
  `Domain_Organisation_acronym_ar` VARCHAR(45) NULL,
  PRIMARY KEY (`idDomain_Organisation`),
  UNIQUE INDEX `idDomain_Organisation_UNIQUE` (`idDomain_Organisation` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`region` (
  `idRegion` INT NOT NULL AUTO_INCREMENT,
  `region_label_fr` VARCHAR(45) NULL,
  `region_label_ar` VARCHAR(45) NULL,
  `region_acronym_fr` VARCHAR(45) NULL,
  `region_acronym_ar` VARCHAR(45) NULL,
  PRIMARY KEY (`idRegion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`sector` (
  `idSector` INT NOT NULL AUTO_INCREMENT,
  `label_sector_fr` VARCHAR(45) NULL,
  `label_sector_ar` VARCHAR(45) NULL,
  `acronym_sector_fr` VARCHAR(45) NULL,
  `acronym_sector_ar` VARCHAR(45) NULL,
  `region_ref_id` INT NULL,
  PRIMARY KEY (`idSector`),
  INDEX `fk_Sector_1_idx` (`region_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Sector_1`
    FOREIGN KEY (`region_ref_id`)
    REFERENCES `Archive`.`region` (`idRegion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`organisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`organisation` (
  `id_Organisation` INT NOT NULL AUTO_INCREMENT,
  `Organisation_name_ar` VARCHAR(255) NULL,
  `Organisation_name_fr` VARCHAR(255) NULL,
  `ACRONYM_AR` VARCHAR(45) NULL,
  `ACRONYM_FR` VARCHAR(45) NULL,
  `Organisation_domain_id_ref` INT NULL,
  `sector_ref_id` INT NULL,
  `first_creation_date` DATE NULL,
  `recent_date_creation` DATE NULL,
  `archive_in_theory` TINYINT NULL,
  `archive_stamp` TINYINT NULL,
  `theoretical_staff` INT NULL,
  `actual_staff` INT NULL,
  `theoritical_equipment` VARCHAR(255) NULL,
  `actual_equipment` VARCHAR(255) NULL,
  `has_archive_room` TINYINT NULL,
  `room_adequate` TINYINT NULL,
  `chair_count` INT NULL,
  `sorting_table_count` INT NULL,
  `work_desk_count` INT NULL,
  `photocopier_count` INT NULL,
  `computer_count` INT NULL,
  `printer_count` INT NULL,
  `scanner_count` INT NULL,
  `has_inspection_program` TINYINT NULL,
  `inspection_program_reference` VARCHAR(45) NULL,
  `has_internal_monitoring` TINYINT NULL,
  `monitoring_reference` VARCHAR(45) NULL,
  `archive_under_monitoring` TINYINT NULL,
  `services_organize_archive` TINYINT NULL,
  `services_submit_to_archive` TINYINT NULL,
  `submission_model` TINYINT NULL,
  `fire_protection` TINYINT NULL,
  `theft_protection` TINYINT NULL,
  `water_protection` TINYINT NULL,
  `pest_protection` TINYINT NULL,
  `dust_protection` TINYINT NULL,
  `pack_count` INT NULL,
  `archive_box_count` INT NULL,
  `map_plan_count` INT NULL,
  `card_count` INT NULL,
  `registry_count` INT NULL,
  `electronic_media_count` INT NULL,
  `Organisation_position` VARCHAR(45) NULL,
  `has_classified_data` TINYINT NULL,
  `has_work_documents` TINYINT NULL,
  `has_security_equipment` TINYINT NULL,
  `security_equipment_adequat` TINYINT NULL,
  `does_annuary_migration` TINYINT NULL,
  `work_documents_summarized` TINYINT NULL,
  `work_documents_organized` TINYINT NULL,
  `org_head_title_ar` VARCHAR(255) NULL,
  `org_head_title_fr` VARCHAR(255) NULL,
  `org_head_title_en` VARCHAR(255) NULL,
  PRIMARY KEY (`id_Organisation`),
  INDEX `fk_Organisation_1_idx` (`Organisation_domain_id_ref` ASC) VISIBLE,
  INDEX `fk_Organisation_2_idx` (`sector_ref_id` ASC) VISIBLE,
  UNIQUE INDEX `id_Organisation_UNIQUE` (`id_Organisation` ASC) VISIBLE,
  CONSTRAINT `fk_Organisation_1`
    FOREIGN KEY (`Organisation_domain_id_ref`)
    REFERENCES `Archive`.`domain_organisation` (`idDomain_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organisation_2`
    FOREIGN KEY (`sector_ref_id`)
    REFERENCES `Archive`.`sector` (`idSector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`doc_reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`doc_reference` (
  `reference_id` INT NOT NULL AUTO_INCREMENT,
  `reference_year` INT NULL,
  `reference_ar` VARCHAR(45) NULL,
  `reference_fr` VARCHAR(45) NULL,
  `Organisation_id_Organisation` INT NULL,
  PRIMARY KEY (`reference_id`),
  INDEX `fk_doc_reference_Organisation1_idx` (`Organisation_id_Organisation` ASC) VISIBLE,
  CONSTRAINT `fk_doc_reference_Organisation1`
    FOREIGN KEY (`Organisation_id_Organisation`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`container`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`container` (
  `idContainer` INT NOT NULL AUTO_INCREMENT,
  `type_container` VARCHAR(45) NULL,
  PRIMARY KEY (`idContainer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`profile_rank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`profile_rank` (
  `idprofile_rank` INT NOT NULL AUTO_INCREMENT,
  `profile_rank_label_fr` VARCHAR(45) NULL,
  `profile_rank_label_ar` VARCHAR(45) NULL,
  `profile_rank_acronym_fr` VARCHAR(45) NULL,
  `profile_rank_acronym_ar` VARCHAR(45) NULL,
  `profile_rank_acronym_en` VARCHAR(45) NULL,
  `profile_rank_label_en` VARCHAR(45) NULL,
  PRIMARY KEY (`idprofile_rank`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`availability_state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`availability_state` (
  `id_availability_state` INT NOT NULL,
  `availability_state_ar` VARCHAR(45) NULL,
  `availability_state_fr` VARCHAR(45) NULL,
  `availability_state_en` VARCHAR(45) NULL,
  `availability_state_untill` DATETIME NULL,
  PRIMARY KEY (`id_availability_state`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`career_profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`career_profile` (
  `idProfile` INT NOT NULL AUTO_INCREMENT,
  `Profile_serial` VARCHAR(45) NULL,
  `Profile_rank_id_ref` INT NULL,
  `Profile_position_org` INT NULL,
  `Profile_domain_id_ref` INT NULL,
  `designation_reference` VARCHAR(45) NULL,
  `installation_reference` VARCHAR(45) NULL,
  `career_profile_availability` INT NULL,
  PRIMARY KEY (`idProfile`),
  INDEX `fk_Profile_1_idx` (`Profile_rank_id_ref` ASC) VISIBLE,
  INDEX `fk_Profile_2_idx` (`Profile_position_org` ASC) VISIBLE,
  INDEX `fk_Profile_3_idx` (`Profile_domain_id_ref` ASC) VISIBLE,
  INDEX `fk_career_profile_1_idx` (`career_profile_availability` ASC) VISIBLE,
  CONSTRAINT `fk_Profile_1`
    FOREIGN KEY (`Profile_rank_id_ref`)
    REFERENCES `Archive`.`profile_rank` (`idprofile_rank`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profile_2`
    FOREIGN KEY (`Profile_position_org`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Profile_3`
    FOREIGN KEY (`Profile_domain_id_ref`)
    REFERENCES `Archive`.`domain_organisation` (`idDomain_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_career_profile_1`
    FOREIGN KEY (`career_profile_availability`)
    REFERENCES `Archive`.`availability_state` (`id_availability_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`person` (
  `PERSON_ID` INT NOT NULL AUTO_INCREMENT,
  `Person_name_ar` VARCHAR(255) NULL,
  `Person_lastname_ar` VARCHAR(255) NULL,
  `Person_profile_id_ref` INT NULL,
  `Person_name_latin` VARCHAR(255) NULL,
  `Person_lastname_latin` VARCHAR(255) NULL,
  PRIMARY KEY (`PERSON_ID`),
  INDEX `fk_Person_1_idx` (`Person_profile_id_ref` ASC) VISIBLE,
  CONSTRAINT `fk_Person_1`
    FOREIGN KEY (`Person_profile_id_ref`)
    REFERENCES `Archive`.`career_profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`app_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`app_user` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `USER_NAME` VARCHAR(45) NULL,
  `USER_PASSWORD` VARCHAR(255) NULL,
  `Person_ID` INT NULL,
  `admin_privilege` TINYINT NULL,
  PRIMARY KEY (`USER_ID`),
  INDEX `fk_User_Person_idx` (`Person_ID` ASC) VISIBLE,
  CONSTRAINT `fk_User_Person`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `Archive`.`person` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`document` (
  `Doc_ID` INT NOT NULL AUTO_INCREMENT,
  `Doc_Label` VARCHAR(255) NULL,
  `Doc_size` BIGINT NULL,
  `reference_id` INT NOT NULL,
  `USER_ID` INT NULL,
  `container_ref_id` INT NULL,
  `added_by_user_id_ref` INT NULL,
  `document_url` VARCHAR(255) NULL,
  PRIMARY KEY (`Doc_ID`, `reference_id`),
  INDEX `fk_Document_User1_idx` (`container_ref_id` ASC) VISIBLE,
  INDEX `fk_Document_reference1_idx` (`reference_id` ASC) VISIBLE,
  INDEX `fk_Document_1_idx` (`added_by_user_id_ref` ASC) VISIBLE,
  UNIQUE INDEX `Doc_ID_UNIQUE` (`Doc_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Document_reference1`
    FOREIGN KEY (`reference_id`)
    REFERENCES `Archive`.`doc_reference` (`reference_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Document_User1`
    FOREIGN KEY (`container_ref_id`)
    REFERENCES `Archive`.`container` (`idContainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Document_1`
    FOREIGN KEY (`added_by_user_id_ref`)
    REFERENCES `Archive`.`app_user` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`transcript`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`transcript` (
  `idTranscript` INT NOT NULL AUTO_INCREMENT,
  `reference_transcript` VARCHAR(45) NULL,
  `sign_date` DATE NULL,
  `transcript_url` VARCHAR(255) NULL,
  PRIMARY KEY (`idTranscript`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`document_type` (
  `idDocument_type` INT NOT NULL AUTO_INCREMENT,
  `document_type_label_fr` VARCHAR(45) NULL,
  `document_type_label_ar` VARCHAR(45) NULL,
  PRIMARY KEY (`idDocument_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`elimination`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`elimination` (
  `idElimination` INT NOT NULL AUTO_INCREMENT,
  `max_eliminated_date` DATE NULL,
  `min_eliminated_date` DATE NULL,
  `id_transcript` INT NOT NULL,
  `doc_type_ref` INT NOT NULL,
  `elimination_container_ref_id` INT NOT NULL,
  PRIMARY KEY (`idElimination`, `id_transcript`, `doc_type_ref`),
  INDEX `fk_Elimination_1_idx` (`doc_type_ref` ASC) VISIBLE,
  INDEX `fk_Elimination_2_idx` (`elimination_container_ref_id` ASC) VISIBLE,
  UNIQUE INDEX `id_transcript_UNIQUE` (`id_transcript` ASC) VISIBLE,
  UNIQUE INDEX `doc_type_ref_UNIQUE` (`doc_type_ref` ASC) VISIBLE,
  UNIQUE INDEX `elimination_container_ref_id_UNIQUE` (`elimination_container_ref_id` ASC) VISIBLE,
  CONSTRAINT `id_ref_transcript`
    FOREIGN KEY (`id_transcript`)
    REFERENCES `Archive`.`transcript` (`idTranscript`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elimination_1`
    FOREIGN KEY (`doc_type_ref`)
    REFERENCES `Archive`.`document_type` (`idDocument_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elimination_2`
    FOREIGN KEY (`elimination_container_ref_id`)
    REFERENCES `Archive`.`container` (`idContainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`communication_demand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`communication_demand` (
  `idCommunication_demand` INT NOT NULL AUTO_INCREMENT,
  `Communication_demanding_org_ref_id` INT NULL,
  PRIMARY KEY (`idCommunication_demand`),
  INDEX `fk_Communication_demand_1_idx` (`Communication_demanding_org_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Communication_demand_1`
    FOREIGN KEY (`Communication_demanding_org_ref_id`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`transfer` (
  `idTransfer` INT NOT NULL AUTO_INCREMENT,
  `source_organisation_id_ref` INT NULL,
  `destination_organisation_id_ref` INT NULL,
  `container_ref_id` VARCHAR(45) NULL,
  PRIMARY KEY (`idTransfer`),
  INDEX `fk_Transfer_1_idx` (`source_organisation_id_ref` ASC) VISIBLE,
  INDEX `fk_Transfer_2_idx` (`destination_organisation_id_ref` ASC) VISIBLE,
  UNIQUE INDEX `source_organisation_id_ref_UNIQUE` (`source_organisation_id_ref` ASC) VISIBLE,
  CONSTRAINT `fk_Transfer_1`
    FOREIGN KEY (`source_organisation_id_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transfer_2`
    FOREIGN KEY (`destination_organisation_id_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`document_type_belongings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`document_type_belongings` (
  `iddocument_type_belongings` INT NOT NULL AUTO_INCREMENT,
  `belonging_domain_id_ref` INT NULL,
  `belonging_type_id_ref` INT NULL,
  `belonging_code` VARCHAR(45) NULL,
  `document_type_belonging_age` INT NULL,
  PRIMARY KEY (`iddocument_type_belongings`),
  INDEX `fk_document_type_belongings_1_idx` (`belonging_type_id_ref` ASC) VISIBLE,
  INDEX `fk_document_type_belongings_2_idx` (`belonging_domain_id_ref` ASC) VISIBLE,
  CONSTRAINT `fk_document_type_belongings_1`
    FOREIGN KEY (`belonging_type_id_ref`)
    REFERENCES `Archive`.`document_type` (`idDocument_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_document_type_belongings_2`
    FOREIGN KEY (`belonging_domain_id_ref`)
    REFERENCES `Archive`.`domain_organisation` (`idDomain_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`session` (
  `idsession` INT NOT NULL AUTO_INCREMENT,
  `session_start_date` DATE NULL,
  `session_end_date` DATE NULL,
  PRIMARY KEY (`idsession`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`trainee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`trainee` (
  `idtrainee` INT NOT NULL AUTO_INCREMENT,
  `profile_ref_id` INT NULL,
  `session_ref_id` INT NULL,
  `trainee_mark` VARCHAR(45) NULL,
  `trainee_evaluation` VARCHAR(45) NULL,
  PRIMARY KEY (`idtrainee`),
  INDEX `fk_trainee_1_idx` (`profile_ref_id` ASC) VISIBLE,
  INDEX `fk_trainee_2_idx` (`session_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_trainee_1`
    FOREIGN KEY (`profile_ref_id`)
    REFERENCES `Archive`.`career_profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trainee_2`
    FOREIGN KEY (`session_ref_id`)
    REFERENCES `Archive`.`session` (`idsession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`store` (
  `idStore` INT NOT NULL AUTO_INCREMENT,
  `Storetype` VARCHAR(45) NULL,
  `store_label_fr` VARCHAR(45) NULL,
  `store_label_ar` VARCHAR(45) NULL,
  `store_acronym_fr` VARCHAR(45) NULL,
  `store_acronym_ar` VARCHAR(45) NULL,
  PRIMARY KEY (`idStore`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`bay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`bay` (
  `idBay` INT NOT NULL AUTO_INCREMENT,
  `Store_ref_id` INT NULL,
  `Bay_ref_fr` VARCHAR(45) NULL,
  `Bay_ref_ar` VARCHAR(45) NULL,
  PRIMARY KEY (`idBay`),
  INDEX `fk_Bay_1_idx` (`Store_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bay_1`
    FOREIGN KEY (`Store_ref_id`)
    REFERENCES `Archive`.`store` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`cob`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`cob` (
  `idCob` INT NOT NULL AUTO_INCREMENT,
  `Cob_ref_fr` VARCHAR(45) NULL,
  `Cob_ref_ar` VARCHAR(45) NULL,
  `bay_ref_id` INT NULL,
  PRIMARY KEY (`idCob`),
  INDEX `fk_Cob_1_idx` (`bay_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cob_1`
    FOREIGN KEY (`bay_ref_id`)
    REFERENCES `Archive`.`bay` (`idBay`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`shelf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`shelf` (
  `idShelf` INT NOT NULL AUTO_INCREMENT,
  `Shelf_ref_fr` VARCHAR(45) NULL,
  `Shelf_ref_ar` VARCHAR(45) NULL,
  `cob_ref_id` INT NULL,
  PRIMARY KEY (`idShelf`),
  INDEX `fk_Shelf_1_idx` (`cob_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Shelf_1`
    FOREIGN KEY (`cob_ref_id`)
    REFERENCES `Archive`.`cob` (`idCob`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`cabinet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`cabinet` (
  `idCabinet` INT NOT NULL AUTO_INCREMENT,
  `Cabinet_store_ref_id` INT NULL,
  `Cabinet_ref_ar` VARCHAR(45) NULL,
  `Cabinet_ref_fr` VARCHAR(45) NULL,
  PRIMARY KEY (`idCabinet`),
  INDEX `fk_Cabinet_1_idx` (`Cabinet_store_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cabinet_1`
    FOREIGN KEY (`Cabinet_store_ref_id`)
    REFERENCES `Archive`.`store` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`container_position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`container_position` (
  `idContainer_position` INT NOT NULL AUTO_INCREMENT,
  `Container_position_shelf_ref_id` INT NULL,
  `Container_position_cabinet_ref_id` INT NULL,
  PRIMARY KEY (`idContainer_position`),
  INDEX `fk_Container_position_1_idx` (`Container_position_shelf_ref_id` ASC) VISIBLE,
  INDEX `fk_Container_position_2_idx` (`Container_position_cabinet_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Container_position_1`
    FOREIGN KEY (`Container_position_shelf_ref_id`)
    REFERENCES `Archive`.`shelf` (`idShelf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Container_position_2`
    FOREIGN KEY (`Container_position_cabinet_ref_id`)
    REFERENCES `Archive`.`cabinet` (`idCabinet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`contained_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`contained_types` (
  `idContained_types` INT NOT NULL AUTO_INCREMENT,
  `container_type_ref_id` INT NULL,
  `types_contained_ref_id` INT NULL,
  `Container_position_ref_id` INT NULL,
  PRIMARY KEY (`idContained_types`),
  INDEX `fk_Contained_types_1_idx` (`container_type_ref_id` ASC) VISIBLE,
  INDEX `fk_Contained_types_2_idx` (`types_contained_ref_id` ASC) VISIBLE,
  INDEX `fk_Contained_types_3_idx` (`Container_position_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Contained_types_1`
    FOREIGN KEY (`container_type_ref_id`)
    REFERENCES `Archive`.`container` (`idContainer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contained_types_2`
    FOREIGN KEY (`types_contained_ref_id`)
    REFERENCES `Archive`.`document_type` (`idDocument_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Contained_types_3`
    FOREIGN KEY (`Container_position_ref_id`)
    REFERENCES `Archive`.`container_position` (`idContainer_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`communication_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`communication_response` (
  `idCommunication_response` INT NOT NULL AUTO_INCREMENT,
  `Communication_demand_ref_id` INT NULL,
  PRIMARY KEY (`idCommunication_response`),
  INDEX `fk_Communication_response_1_idx` (`Communication_demand_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Communication_response_1`
    FOREIGN KEY (`Communication_demand_ref_id`)
    REFERENCES `Archive`.`communication_demand` (`idCommunication_demand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`communication_subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`communication_subject` (
  `idCommunication_subject` INT NOT NULL AUTO_INCREMENT,
  `Communicated_doc_ref_id` INT NULL,
  `Communication_response_ref_id` INT NULL,
  PRIMARY KEY (`idCommunication_subject`),
  INDEX `fk_Communication_subject_1_idx` (`Communication_response_ref_id` ASC) VISIBLE,
  INDEX `fk_Communication_subject_2_idx` (`Communicated_doc_ref_id` ASC) VISIBLE,
  CONSTRAINT `fk_Communication_subject_1`
    FOREIGN KEY (`Communication_response_ref_id`)
    REFERENCES `Archive`.`communication_response` (`idCommunication_response`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Communication_subject_2`
    FOREIGN KEY (`Communicated_doc_ref_id`)
    REFERENCES `Archive`.`document` (`Doc_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`transferred_contained_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`transferred_contained_types` (
  `idtransferred_contained_types` INT NOT NULL AUTO_INCREMENT,
  `transferred_contained_types_id_ref` INT NULL,
  `transferred_types_contained` INT NULL,
  INDEX `fk_transferred_contained_types_1_idx` (`transferred_types_contained` ASC) VISIBLE,
  INDEX `fk_transferred_contained_types_2_idx` (`transferred_contained_types_id_ref` ASC) VISIBLE,
  PRIMARY KEY (`idtransferred_contained_types`),
  CONSTRAINT `fk_transferred_contained_types_1`
    FOREIGN KEY (`transferred_types_contained`)
    REFERENCES `Archive`.`contained_types` (`idContained_types`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transferred_contained_types_2`
    FOREIGN KEY (`transferred_contained_types_id_ref`)
    REFERENCES `Archive`.`transfer` (`idTransfer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`inspection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`inspection` (
  `id_inspection` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NULL,
  `inspection_transcript` LONGTEXT NULL,
  `insp_org_ref` INT NULL,
  `end_date` DATE NULL,
  PRIMARY KEY (`id_inspection`),
  INDEX `fk_Inspection_1_idx` (`insp_org_ref` ASC) VISIBLE,
  CONSTRAINT `fk_Inspection_1`
    FOREIGN KEY (`insp_org_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`review` (
  `id_review` INT NOT NULL AUTO_INCREMENT,
  `review_type` VARCHAR(45) NULL,
  `review_reference` VARCHAR(45) NULL,
  `org_ref` INT NULL,
  PRIMARY KEY (`id_review`),
  INDEX `fk_review_1_idx` (`org_ref` ASC) VISIBLE,
  CONSTRAINT `fk_review_1`
    FOREIGN KEY (`org_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`reviewed_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`reviewed_year` (
  `id_reviewed_year` INT NOT NULL,
  `reviewed_year` INT NULL,
  `treated_archive_boxes` INT NULL,
  `inventoried_archive_boxes` INT NULL,
  `reviewed_year_note` VARCHAR(45) NULL,
  `parent_review_id` INT NULL,
  PRIMARY KEY (`id_reviewed_year`),
  CONSTRAINT `fk_reviewed_year_1`
    FOREIGN KEY (`id_reviewed_year`)
    REFERENCES `Archive`.`review` (`id_review`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`registry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`registry` (
  `id_registry` INT NOT NULL AUTO_INCREMENT,
  `registry_designation` VARCHAR(45) NULL,
  `registry_purpose` VARCHAR(45) NULL,
  `registry_code` VARCHAR(45) NULL,
  `registry_belonging_service` VARCHAR(45) NULL,
  `registry_belonging_org` INT NULL,
  PRIMARY KEY (`id_registry`),
  INDEX `fk_registry_1_idx` (`registry_belonging_org` ASC) VISIBLE,
  CONSTRAINT `fk_registry_1`
    FOREIGN KEY (`registry_belonging_org`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`mobile_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`mobile_equipment` (
  `id_mobile_equipment` INT NOT NULL AUTO_INCREMENT,
  `mobile_equipment_desc_ar` VARCHAR(255) NULL,
  `mobile_equipment_desc_fr` VARCHAR(255) NULL,
  `organisation_ref` INT NULL,
  PRIMARY KEY (`id_mobile_equipment`),
  INDEX `fk_mobile_equipment_1_idx` (`organisation_ref` ASC) VISIBLE,
  CONSTRAINT `fk_mobile_equipment_1`
    FOREIGN KEY (`organisation_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`budget`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`budget` (
  `id_budget` INT NOT NULL AUTO_INCREMENT,
  `budget_year` DATE NULL,
  `budget_to_org_ref` INT NULL,
  `budget_type` VARCHAR(45) NULL,
  PRIMARY KEY (`id_budget`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`paragraph`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`paragraph` (
  `id_paragraph` INT NOT NULL AUTO_INCREMENT,
  `paragraph_desc` VARCHAR(45) NULL,
  `paragraph_budget` DOUBLE NULL,
  `paragraph_consumed_budget` DOUBLE NULL,
  `budget_ref` INT NULL,
  PRIMARY KEY (`id_paragraph`),
  INDEX `fk_paragraph_1_idx` (`budget_ref` ASC) VISIBLE,
  CONSTRAINT `fk_paragraph_1`
    FOREIGN KEY (`budget_ref`)
    REFERENCES `Archive`.`budget` (`id_budget`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`invoice` (
  `id_invoice` INT NOT NULL AUTO_INCREMENT,
  `invoice_total` DOUBLE NULL,
  `invoice_date` DATE NULL,
  `invoice_paragraph` INT NULL,
  PRIMARY KEY (`id_invoice`),
  INDEX `fk_invoice_1_idx` (`invoice_paragraph` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_1`
    FOREIGN KEY (`invoice_paragraph`)
    REFERENCES `Archive`.`paragraph` (`id_paragraph`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`vehicle` (
  `id_vehicle` INT NOT NULL AUTO_INCREMENT,
  `vehicle_serial` VARCHAR(255) NULL,
  `chassis_number` VARCHAR(45) NULL,
  `vehicle_name` VARCHAR(255) NULL,
  `org_ref` INT NULL,
  `as_mobile_equipment_ref` INT NULL,
  `vehicle_invoice_ref` INT NULL,
  `vehicle_state_ref` INT NULL,
  PRIMARY KEY (`id_vehicle`),
  INDEX `fk_vehicle_2_idx` (`as_mobile_equipment_ref` ASC) VISIBLE,
  INDEX `fk_vehicle_1_idx` (`org_ref` ASC) VISIBLE,
  INDEX `fk_vehicle_3_idx` (`vehicle_invoice_ref` ASC) VISIBLE,
  INDEX `fk_vehicle_4_idx` (`vehicle_state_ref` ASC) VISIBLE,
  CONSTRAINT `fk_vehicle_1`
    FOREIGN KEY (`org_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_2`
    FOREIGN KEY (`as_mobile_equipment_ref`)
    REFERENCES `Archive`.`mobile_equipment` (`id_mobile_equipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_3`
    FOREIGN KEY (`vehicle_invoice_ref`)
    REFERENCES `Archive`.`invoice` (`id_invoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_4`
    FOREIGN KEY (`vehicle_state_ref`)
    REFERENCES `Archive`.`availability_state` (`id_availability_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`office_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`office_equipment` (
  `id_office_equipment` INT NOT NULL AUTO_INCREMENT,
  `office_equipment_type` VARCHAR(45) NULL,
  `is_domain_specific` VARCHAR(45) NULL,
  `domain_specific_to` INT NULL,
  `office_equipment_name` VARCHAR(45) NULL,
  `office_equipment_count` INT NULL,
  PRIMARY KEY (`id_office_equipment`),
  INDEX `fk_office_equipment_1_idx` (`domain_specific_to` ASC) VISIBLE,
  CONSTRAINT `fk_office_equipment_1`
    FOREIGN KEY (`domain_specific_to`)
    REFERENCES `Archive`.`domain_organisation` (`idDomain_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`furniture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`furniture` (
  `idfurniture` INT NOT NULL AUTO_INCREMENT,
  `furniture_as_equipment_ref` INT NULL,
  `furniture_org_ref` INT NULL,
  `furniture_name` VARCHAR(255) NULL,
  `furniture_code` VARCHAR(45) NULL,
  `furniture_count` INT NULL,
  `furniture_serial` VARCHAR(45) NULL,
  `furniture_note` VARCHAR(45) NULL,
  `furniture_source` INT NULL,
  `furniture_invoice_ref` INT NULL,
  `furniture_availability_ref` INT NULL,
  PRIMARY KEY (`idfurniture`),
  INDEX `fk_furniture_2_idx` (`furniture_as_equipment_ref` ASC) VISIBLE,
  INDEX `fk_furniture_1_idx` (`furniture_org_ref` ASC) VISIBLE,
  INDEX `fk_furniture_3_idx` (`furniture_source` ASC) VISIBLE,
  INDEX `fk_furniture_4_idx` (`furniture_invoice_ref` ASC) VISIBLE,
  INDEX `fk_furniture_5_idx` (`furniture_availability_ref` ASC) VISIBLE,
  CONSTRAINT `fk_furniture_1`
    FOREIGN KEY (`furniture_org_ref`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_furniture_2`
    FOREIGN KEY (`furniture_as_equipment_ref`)
    REFERENCES `Archive`.`office_equipment` (`id_office_equipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_furniture_3`
    FOREIGN KEY (`furniture_source`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_furniture_4`
    FOREIGN KEY (`furniture_invoice_ref`)
    REFERENCES `Archive`.`invoice` (`id_invoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_furniture_5`
    FOREIGN KEY (`furniture_availability_ref`)
    REFERENCES `Archive`.`availability_state` (`id_availability_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`component`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`component` (
  `id_component` INT NOT NULL AUTO_INCREMENT,
  `component_name_ar` VARCHAR(255) NULL,
  `component_name_fr` VARCHAR(255) NULL,
  `component_type` VARCHAR(45) NULL,
  `component_mission_ar` VARCHAR(255) NULL,
  `component_mission_fr` VARCHAR(255) NULL,
  `component_parent` INT NULL,
  `component_org` INT NULL,
  `component_ending_date` DATE NULL,
  `component_starting_date` DATE NULL,
  `component_head` INT NULL,
  `component_members` INT NULL,
  PRIMARY KEY (`id_component`),
  INDEX `fk_component_1_idx` (`component_parent` ASC) VISIBLE,
  INDEX `fk_component_2_idx` (`component_org` ASC) VISIBLE,
  CONSTRAINT `fk_component_1`
    FOREIGN KEY (`component_parent`)
    REFERENCES `Archive`.`component` (`id_component`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_component_2`
    FOREIGN KEY (`component_org`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`component_community`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`component_community` (
  `id_component_membership` INT NOT NULL AUTO_INCREMENT,
  `component_member_id` INT NULL,
  `component_member_in` INT NULL,
  `component_membership_activity` VARCHAR(45) NULL,
  PRIMARY KEY (`id_component_membership`),
  INDEX `fk_component_community_1_idx` (`component_member_id` ASC) VISIBLE,
  INDEX `fk_component_community_2_idx` (`component_member_in` ASC) VISIBLE,
  CONSTRAINT `fk_component_community_1`
    FOREIGN KEY (`component_member_id`)
    REFERENCES `Archive`.`career_profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_component_community_2`
    FOREIGN KEY (`component_member_in`)
    REFERENCES `Archive`.`component` (`id_component`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`storable_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`storable_item` (
  `id_storable_item` INT NOT NULL AUTO_INCREMENT,
  `storable_item_position` INT NULL,
  `storable_item_quantity` VARCHAR(45) NULL,
  `storable_item_last_updated` DATETIME NULL,
  `storable_item_invoice_ref` INT NULL,
  `storable_item_availability_ref` INT NULL,
  PRIMARY KEY (`id_storable_item`),
  INDEX `fk_storable_item_1_idx` (`storable_item_position` ASC) VISIBLE,
  INDEX `fk_storable_item_2_idx` (`storable_item_invoice_ref` ASC) VISIBLE,
  INDEX `fk_storable_item_3_idx` (`storable_item_availability_ref` ASC) VISIBLE,
  CONSTRAINT `fk_storable_item_1`
    FOREIGN KEY (`storable_item_position`)
    REFERENCES `Archive`.`component` (`id_component`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storable_item_2`
    FOREIGN KEY (`storable_item_invoice_ref`)
    REFERENCES `Archive`.`invoice` (`id_invoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_storable_item_3`
    FOREIGN KEY (`storable_item_availability_ref`)
    REFERENCES `Archive`.`availability_state` (`id_availability_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`provision_demand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`provision_demand` (
  `id_provision_demand` INT NOT NULL,
  `provision_demand_issuer` INT NULL,
  `provision_demand_destination` INT NULL,
  `provision_demand_item` INT NULL,
  `provision_demand_quantity` VARCHAR(45) NULL,
  `provision_demand_datetime` DATETIME NULL,
  `provision_demand_state` VARCHAR(255) NULL,
  PRIMARY KEY (`id_provision_demand`),
  INDEX `fk_provision_demand_1_idx` (`provision_demand_issuer` ASC) VISIBLE,
  INDEX `fk_provision_demand_2_idx` (`provision_demand_destination` ASC) VISIBLE,
  INDEX `fk_provision_demand_3_idx` (`provision_demand_item` ASC) VISIBLE,
  CONSTRAINT `fk_provision_demand_1`
    FOREIGN KEY (`provision_demand_issuer`)
    REFERENCES `Archive`.`component` (`id_component`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provision_demand_2`
    FOREIGN KEY (`provision_demand_destination`)
    REFERENCES `Archive`.`component` (`id_component`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provision_demand_3`
    FOREIGN KEY (`provision_demand_item`)
    REFERENCES `Archive`.`storable_item` (`id_storable_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`visitor` (
  `id_visitor` INT NOT NULL AUTO_INCREMENT,
  `visitor_as_person` INT NULL,
  `visitor_purpose` VARCHAR(255) NULL,
  `visitor_entry` DATETIME NULL,
  `visitor_leave` DATETIME NULL,
  PRIMARY KEY (`id_visitor`),
  INDEX `fk_visitor_1_idx` (`visitor_as_person` ASC) VISIBLE,
  CONSTRAINT `fk_visitor_1`
    FOREIGN KEY (`visitor_as_person`)
    REFERENCES `Archive`.`person` (`PERSON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`course` (
  `idcourse` INT NOT NULL AUTO_INCREMENT,
  `course_teacher` INT NULL,
  `course_title_ar` VARCHAR(255) NULL,
  `course_title_fr` VARCHAR(45) NULL,
  `course_title_en` VARCHAR(45) NULL,
  `course_session` INT NULL,
  `course_start` DATETIME NULL,
  `course_end` DATETIME NULL,
  PRIMARY KEY (`idcourse`),
  INDEX `fk_course_1_idx` (`course_teacher` ASC) VISIBLE,
  INDEX `fk_course_2_idx` (`course_session` ASC) VISIBLE,
  CONSTRAINT `fk_course_1`
    FOREIGN KEY (`course_teacher`)
    REFERENCES `Archive`.`career_profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_2`
    FOREIGN KEY (`course_session`)
    REFERENCES `Archive`.`session` (`idsession`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`security_shift_position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`security_shift_position` (
  `id_shift_position` INT NOT NULL AUTO_INCREMENT,
  `shift_position_title_ar` VARCHAR(45) NULL,
  `shift_position_title_fr` VARCHAR(45) NULL,
  `shift_position_title_en` VARCHAR(45) NULL,
  `security_shift_details_ar` DATETIME NULL,
  `security_shift_details_fr` DATETIME NULL,
  `security_shift_details_en` DATETIME NULL,
  PRIMARY KEY (`id_shift_position`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Archive`.`security_shift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Archive`.`security_shift` (
  `id_security_shift` INT NOT NULL AUTO_INCREMENT,
  `shift_position_ref` INT NULL,
  `security_shift_at` INT NULL,
  `security_shift_who` INT NULL,
  `security_shift_what` INT NULL,
  `security_shift_start` DATETIME NULL,
  `security_shift_end` DATETIME NULL,
  `security_shift_responsible` INT NULL,
  `security_shift_approved` TINYINT NULL,
  `security_shift_state` INT NULL,
  PRIMARY KEY (`id_security_shift`),
  INDEX `fk_security_shift_1_idx` (`security_shift_at` ASC) VISIBLE,
  INDEX `fk_security_shift_3_idx` (`security_shift_what` ASC) VISIBLE,
  INDEX `fk_security_shift_4_idx` (`shift_position_ref` ASC) VISIBLE,
  INDEX `fk_security_shift_5_idx` (`security_shift_responsible` ASC) VISIBLE,
  INDEX `fk_security_shift_6_idx` (`security_shift_state` ASC) VISIBLE,
  INDEX `fk_security_shift_2_idx` (`security_shift_who` ASC) VISIBLE,
  CONSTRAINT `fk_security_shift_1`
    FOREIGN KEY (`security_shift_at`)
    REFERENCES `Archive`.`organisation` (`id_Organisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_shift_2`
    FOREIGN KEY (`security_shift_who`)
    REFERENCES `Archive`.`career_profile` (`idProfile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_shift_3`
    FOREIGN KEY (`security_shift_what`)
    REFERENCES `Archive`.`storable_item` (`id_storable_item`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_shift_4`
    FOREIGN KEY (`shift_position_ref`)
    REFERENCES `Archive`.`security_shift_position` (`id_shift_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_shift_5`
    FOREIGN KEY (`security_shift_responsible`)
    REFERENCES `Archive`.`app_user` (`USER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_shift_6`
    FOREIGN KEY (`security_shift_state`)
    REFERENCES `Archive`.`availability_state` (`id_availability_state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Archive` ;

-- -----------------------------------------------------
-- procedure InsertDataIntoMultipleTables
-- -----------------------------------------------------

DELIMITER $$
USE `Archive`$$
CREATE PROCEDURE InsertDataIntoMultipleTables (
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_address VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error occurred. Transaction rolled back.';
    END;

    START TRANSACTION;

    INSERT INTO table1 (name, email) VALUES (p_name, p_email);
    SET @last_id := LAST_INSERT_ID();

    INSERT INTO table2 (user_id, address) VALUES (@last_id, p_address);

    COMMIT;

    SELECT 'Data inserted successfully.';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetEmployeeCount
-- -----------------------------------------------------

DELIMITER $$
USE `Archive`$$
CREATE PROCEDURE GetEmployeeCount(IN departmentId INT, OUT employeeCount INT)
BEGIN
    SELECT COUNT(*) INTO employeeCount
    FROM employees
    WHERE department_id = departmentId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Trainee
-- -----------------------------------------------------

DELIMITER $$
USE `Archive`$$
CREATE PROCEDURE Trainee (
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_address VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'An error occurred. Transaction rolled back.';
    END;

    START TRANSACTION;

    INSERT INTO table1 (name, email) VALUES (p_name, p_email);
    SET @last_id := LAST_INSERT_ID();

    INSERT INTO table2 (user_id, address) VALUES (@last_id, p_address);

    COMMIT;

    SELECT 'Data inserted successfully.';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InsertTrainee
-- -----------------------------------------------------

DELIMITER $$
USE `Archive`$$
CREATE PROCEDURE InsertTrainee (
    IN p_domain_id INT,
    IN p_org_id INT,
    IN p_region_id INT,
    IN p_sector_id INT,
    IN p_session_id INT,
    IN p_rank_id INT,
    IN p_lastname VARCHAR(45),
    IN p_name VARCHAR(45),
    IN p_serial VARCHAR(255),
    IN p_mark VARCHAR(45),
    IN p_evaluation VARCHAR(45)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
SELECT 'An error occurred. Transaction rolled back.';
    END;
    START TRANSACTION;
    INSERT INTO profile (Profile_serial,Profile_rank_id_ref,Profile_position_org,Profile_domain_id_ref) VALUES (p_name, p_rank_id,p_org_id,p_domain_id);
    SET @last_profile_id := LAST_INSERT_ID();
    INSERT INTO trainee (profile_ref_id, session_ref_id,trainee_mark,trainee_evaluation) VALUES (@last_profile_id, p_session_id,p_mark,p_evaluation);
	INSERT INTO Person (Person_profile_id_ref, Person_name,Person_lastname) VALUES (@last_profile_id, p_name,p_lastname);
    COMMIT;

SELECT 'Data inserted successfully.';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetTraineeCountInSession
-- -----------------------------------------------------

DELIMITER $$
USE `Archive`$$
CREATE PROCEDURE GetTraineeCountInSession(IN sessionId INT, OUT traineeCount INT)
BEGIN
    SELECT COUNT(*) INTO traineeCount
    FROM trainee
    WHERE sessionId = session_ref_id;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
