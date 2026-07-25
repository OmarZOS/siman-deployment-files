from sqlalchemy import BigInteger, Column, Date, DateTime, Float, ForeignKeyConstraint, Index, Integer, String
from sqlalchemy.dialects.mysql import LONGTEXT, TINYINT

from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()


class AvailabilityState(Base):
    __tablename__ = 'availability_state'

    id_availability_state = Column(Integer, primary_key=True)
    availability_state_ar = Column(String(45))
    availability_state_fr = Column(String(45))
    availability_state_en = Column(String(45))
    availability_state_untill = Column(DateTime)

    career_profile = relationship('CareerProfile', back_populates='availability_state')
    furniture = relationship('Furniture', back_populates='availability_state')
    storable_item = relationship('StorableItem', back_populates='availability_state')
    vehicle = relationship('Vehicle', back_populates='availability_state')
    security_shift = relationship('SecurityShift', back_populates='availability_state')


class Budget(Base):
    __tablename__ = 'budget'

    id_budget = Column(Integer, primary_key=True)
    budget_year = Column(Date)
    budget_to_org_ref = Column(Integer)
    budget_type = Column(String(45))

    paragraph = relationship('Paragraph', back_populates='budget')


class Container(Base):
    __tablename__ = 'container'

    idContainer = Column(Integer, primary_key=True)
    type_container = Column(String(45))

    elimination = relationship('Elimination', back_populates='elimination_container_ref')
    contained_types = relationship('ContainedTypes', back_populates='container_type_ref')
    document = relationship('Document', back_populates='container_ref')


class DocumentType(Base):
    __tablename__ = 'document_type'

    idDocument_type = Column(Integer, primary_key=True)
    document_type_label_fr = Column(String(45))
    document_type_label_ar = Column(String(45))

    document_type_belongings = relationship('DocumentTypeBelongings', back_populates='document_type')
    elimination = relationship('Elimination', back_populates='document_type')
    contained_types = relationship('ContainedTypes', back_populates='types_contained_ref')


class DomainOrganisation(Base):
    __tablename__ = 'domain_organisation'
    __table_args__ = (
        Index('idDomain_Organisation_UNIQUE', 'idDomain_Organisation', unique=True),
    )

    idDomain_Organisation = Column(Integer, primary_key=True)
    Domain_Organisation_label_fr = Column(String(45))
    Domain_Organisation_label_ar = Column(String(45))
    Domain_Organisation_acronym_fr = Column(String(45))
    Domain_Organisation_acronym_ar = Column(String(45))

    document_type_belongings = relationship('DocumentTypeBelongings', back_populates='domain_organisation')
    office_equipment = relationship('OfficeEquipment', back_populates='domain_organisation')
    organisation = relationship('Organisation', back_populates='domain_organisation')
    career_profile = relationship('CareerProfile', back_populates='domain_organisation')


class ProfileRank(Base):
    __tablename__ = 'profile_rank'

    idprofile_rank = Column(Integer, primary_key=True)
    profile_rank_label_fr = Column(String(45))
    profile_rank_label_ar = Column(String(45))
    profile_rank_acronym_fr = Column(String(45))
    profile_rank_acronym_ar = Column(String(45))
    profile_rank_acronym_en = Column(String(45))
    profile_rank_label_en = Column(String(45))

    career_profile = relationship('CareerProfile', back_populates='profile_rank')


class Region(Base):
    __tablename__ = 'region'

    idRegion = Column(Integer, primary_key=True)
    region_label_fr = Column(String(45))
    region_label_ar = Column(String(45))
    region_acronym_fr = Column(String(45))
    region_acronym_ar = Column(String(45))

    sector = relationship('Sector', back_populates='region_ref')


class SecurityShiftPosition(Base):
    __tablename__ = 'security_shift_position'

    id_shift_position = Column(Integer, primary_key=True)
    shift_position_title_ar = Column(String(45))
    shift_position_title_fr = Column(String(45))
    shift_position_title_en = Column(String(45))
    security_shift_details_ar = Column(DateTime)
    security_shift_details_fr = Column(DateTime)
    security_shift_details_en = Column(DateTime)

    security_shift = relationship('SecurityShift', back_populates='security_shift_position')


class Session(Base):
    __tablename__ = 'session'

    idsession = Column(Integer, primary_key=True)
    session_start_date = Column(Date)
    session_end_date = Column(Date)

    course = relationship('Course', back_populates='session')
    trainee = relationship('Trainee', back_populates='session_ref')


class Store(Base):
    __tablename__ = 'store'

    idStore = Column(Integer, primary_key=True)
    Storetype = Column(String(45))
    store_label_fr = Column(String(45))
    store_label_ar = Column(String(45))
    store_acronym_fr = Column(String(45))
    store_acronym_ar = Column(String(45))

    bay = relationship('Bay', back_populates='Store_ref')
    cabinet = relationship('Cabinet', back_populates='Cabinet_store_ref')


class Transcript(Base):
    __tablename__ = 'transcript'

    idTranscript = Column(Integer, primary_key=True)
    reference_transcript = Column(String(45))
    sign_date = Column(Date)
    transcript_url = Column(String(255))

    elimination = relationship('Elimination', back_populates='transcript')


class Bay(Base):
    __tablename__ = 'bay'
    __table_args__ = (
        ForeignKeyConstraint(['Store_ref_id'], ['store.idStore'], name='fk_Bay_1'),
        Index('fk_Bay_1_idx', 'Store_ref_id')
    )

    idBay = Column(Integer, primary_key=True)
    Store_ref_id = Column(Integer)
    Bay_ref_fr = Column(String(45))
    Bay_ref_ar = Column(String(45))

    Store_ref = relationship('Store', back_populates='bay')
    cob = relationship('Cob', back_populates='bay_ref')


class Cabinet(Base):
    __tablename__ = 'cabinet'
    __table_args__ = (
        ForeignKeyConstraint(['Cabinet_store_ref_id'], ['store.idStore'], name='fk_Cabinet_1'),
        Index('fk_Cabinet_1_idx', 'Cabinet_store_ref_id')
    )

    idCabinet = Column(Integer, primary_key=True)
    Cabinet_store_ref_id = Column(Integer)
    Cabinet_ref_ar = Column(String(45))
    Cabinet_ref_fr = Column(String(45))

    Cabinet_store_ref = relationship('Store', back_populates='cabinet')
    container_position = relationship('ContainerPosition', back_populates='Container_position_cabinet_ref')


class DocumentTypeBelongings(Base):
    __tablename__ = 'document_type_belongings'
    __table_args__ = (
        ForeignKeyConstraint(['belonging_domain_id_ref'], ['domain_organisation.idDomain_Organisation'], name='fk_document_type_belongings_2'),
        ForeignKeyConstraint(['belonging_type_id_ref'], ['document_type.idDocument_type'], name='fk_document_type_belongings_1'),
        Index('fk_document_type_belongings_1_idx', 'belonging_type_id_ref'),
        Index('fk_document_type_belongings_2_idx', 'belonging_domain_id_ref')
    )

    iddocument_type_belongings = Column(Integer, primary_key=True)
    belonging_domain_id_ref = Column(Integer)
    belonging_type_id_ref = Column(Integer)
    belonging_code = Column(String(45))
    document_type_belonging_age = Column(Integer)

    domain_organisation = relationship('DomainOrganisation', back_populates='document_type_belongings')
    document_type = relationship('DocumentType', back_populates='document_type_belongings')


class Elimination(Base):
    __tablename__ = 'elimination'
    __table_args__ = (
        ForeignKeyConstraint(['doc_type_ref'], ['document_type.idDocument_type'], name='fk_Elimination_1'),
        ForeignKeyConstraint(['elimination_container_ref_id'], ['container.idContainer'], name='fk_Elimination_2'),
        ForeignKeyConstraint(['id_transcript'], ['transcript.idTranscript'], name='id_ref_transcript'),
        Index('doc_type_ref_UNIQUE', 'doc_type_ref', unique=True),
        Index('elimination_container_ref_id_UNIQUE', 'elimination_container_ref_id', unique=True),
        Index('fk_Elimination_1_idx', 'doc_type_ref'),
        Index('fk_Elimination_2_idx', 'elimination_container_ref_id'),
        Index('id_transcript_UNIQUE', 'id_transcript', unique=True)
    )

    idElimination = Column(Integer, primary_key=True, nullable=False)
    id_transcript = Column(Integer, primary_key=True, nullable=False)
    doc_type_ref = Column(Integer, primary_key=True, nullable=False)
    elimination_container_ref_id = Column(Integer, nullable=False)
    max_eliminated_date = Column(Date)
    min_eliminated_date = Column(Date)

    document_type = relationship('DocumentType', back_populates='elimination')
    elimination_container_ref = relationship('Container', back_populates='elimination')
    transcript = relationship('Transcript', back_populates='elimination')


class OfficeEquipment(Base):
    __tablename__ = 'office_equipment'
    __table_args__ = (
        ForeignKeyConstraint(['domain_specific_to'], ['domain_organisation.idDomain_Organisation'], name='fk_office_equipment_1'),
        Index('fk_office_equipment_1_idx', 'domain_specific_to')
    )

    id_office_equipment = Column(Integer, primary_key=True)
    office_equipment_type = Column(String(45))
    is_domain_specific = Column(String(45))
    domain_specific_to = Column(Integer)
    office_equipment_name = Column(String(45))
    office_equipment_count = Column(Integer)

    domain_organisation = relationship('DomainOrganisation', back_populates='office_equipment')
    furniture = relationship('Furniture', back_populates='office_equipment')


class Paragraph(Base):
    __tablename__ = 'paragraph'
    __table_args__ = (
        ForeignKeyConstraint(['budget_ref'], ['budget.id_budget'], name='fk_paragraph_1'),
        Index('fk_paragraph_1_idx', 'budget_ref')
    )

    id_paragraph = Column(Integer, primary_key=True)
    paragraph_desc = Column(String(45))
    paragraph_budget = Column(Float(asdecimal=True))
    paragraph_consumed_budget = Column(Float(asdecimal=True))
    budget_ref = Column(Integer)

    budget = relationship('Budget', back_populates='paragraph')
    invoice = relationship('Invoice', back_populates='paragraph')


class Sector(Base):
    __tablename__ = 'sector'
    __table_args__ = (
        ForeignKeyConstraint(['region_ref_id'], ['region.idRegion'], name='fk_Sector_1'),
        Index('fk_Sector_1_idx', 'region_ref_id')
    )

    idSector = Column(Integer, primary_key=True)
    label_sector_fr = Column(String(45))
    label_sector_ar = Column(String(45))
    acronym_sector_fr = Column(String(45))
    acronym_sector_ar = Column(String(45))
    region_ref_id = Column(Integer)

    region_ref = relationship('Region', back_populates='sector')
    organisation = relationship('Organisation', back_populates='sector_ref')


class Cob(Base):
    __tablename__ = 'cob'
    __table_args__ = (
        ForeignKeyConstraint(['bay_ref_id'], ['bay.idBay'], name='fk_Cob_1'),
        Index('fk_Cob_1_idx', 'bay_ref_id')
    )

    idCob = Column(Integer, primary_key=True)
    Cob_ref_fr = Column(String(45))
    Cob_ref_ar = Column(String(45))
    bay_ref_id = Column(Integer)

    bay_ref = relationship('Bay', back_populates='cob')
    shelf = relationship('Shelf', back_populates='cob_ref')


class Invoice(Base):
    __tablename__ = 'invoice'
    __table_args__ = (
        ForeignKeyConstraint(['invoice_paragraph'], ['paragraph.id_paragraph'], name='fk_invoice_1'),
        Index('fk_invoice_1_idx', 'invoice_paragraph')
    )

    id_invoice = Column(Integer, primary_key=True)
    invoice_total = Column(Float(asdecimal=True))
    invoice_date = Column(Date)
    invoice_paragraph = Column(Integer)

    paragraph = relationship('Paragraph', back_populates='invoice')
    furniture = relationship('Furniture', back_populates='invoice')
    storable_item = relationship('StorableItem', back_populates='invoice')
    vehicle = relationship('Vehicle', back_populates='invoice')


class Organisation(Base):
    __tablename__ = 'organisation'
    __table_args__ = (
        ForeignKeyConstraint(['Organisation_domain_id_ref'], ['domain_organisation.idDomain_Organisation'], name='fk_Organisation_1'),
        ForeignKeyConstraint(['sector_ref_id'], ['sector.idSector'], name='fk_Organisation_2'),
        Index('fk_Organisation_1_idx', 'Organisation_domain_id_ref'),
        Index('fk_Organisation_2_idx', 'sector_ref_id'),
        Index('id_Organisation_UNIQUE', 'id_Organisation', unique=True)
    )

    id_Organisation = Column(Integer, primary_key=True)
    Organisation_name_ar = Column(String(255))
    Organisation_name_fr = Column(String(255))
    ACRONYM_AR = Column(String(45))
    ACRONYM_FR = Column(String(45))
    Organisation_domain_id_ref = Column(Integer)
    sector_ref_id = Column(Integer)
    first_creation_date = Column(Date)
    recent_date_creation = Column(Date)
    archive_in_theory = Column(TINYINT)
    archive_stamp = Column(TINYINT)
    theoretical_staff = Column(Integer)
    actual_staff = Column(Integer)
    theoritical_equipment = Column(String(255))
    actual_equipment = Column(String(255))
    has_archive_room = Column(TINYINT)
    room_adequate = Column(TINYINT)
    chair_count = Column(Integer)
    sorting_table_count = Column(Integer)
    work_desk_count = Column(Integer)
    photocopier_count = Column(Integer)
    computer_count = Column(Integer)
    printer_count = Column(Integer)
    scanner_count = Column(Integer)
    has_inspection_program = Column(TINYINT)
    inspection_program_reference = Column(String(45))
    has_internal_monitoring = Column(TINYINT)
    monitoring_reference = Column(String(45))
    archive_under_monitoring = Column(TINYINT)
    services_organize_archive = Column(TINYINT)
    services_submit_to_archive = Column(TINYINT)
    submission_model = Column(TINYINT)
    fire_protection = Column(TINYINT)
    theft_protection = Column(TINYINT)
    water_protection = Column(TINYINT)
    pest_protection = Column(TINYINT)
    dust_protection = Column(TINYINT)
    pack_count = Column(Integer)
    archive_box_count = Column(Integer)
    map_plan_count = Column(Integer)
    card_count = Column(Integer)
    registry_count = Column(Integer)
    electronic_media_count = Column(Integer)
    Organisation_position = Column(String(45))
    has_classified_data = Column(TINYINT)
    has_work_documents = Column(TINYINT)
    has_security_equipment = Column(TINYINT)
    security_equipment_adequat = Column(TINYINT)
    does_annuary_migration = Column(TINYINT)
    work_documents_summarized = Column(TINYINT)
    work_documents_organized = Column(TINYINT)
    org_head_title_ar = Column(String(255))
    org_head_title_fr = Column(String(255))
    org_head_title_en = Column(String(255))

    domain_organisation = relationship('DomainOrganisation', back_populates='organisation')
    sector_ref = relationship('Sector', back_populates='organisation')
    career_profile = relationship('CareerProfile', back_populates='organisation')
    communication_demand = relationship('CommunicationDemand', back_populates='Communication_demanding_org_ref')
    component = relationship('Component', back_populates='organisation')
    doc_reference = relationship('DocReference', back_populates='organisation')
    furniture = relationship('Furniture', foreign_keys='[Furniture.furniture_org_ref]', back_populates='organisation')
    furniture_ = relationship('Furniture', foreign_keys='[Furniture.furniture_source]', back_populates='organisation_')
    inspection = relationship('Inspection', back_populates='organisation')
    mobile_equipment = relationship('MobileEquipment', back_populates='organisation')
    registry = relationship('Registry', back_populates='organisation')
    review = relationship('Review', back_populates='organisation')
    transfer = relationship('Transfer', foreign_keys='[Transfer.destination_organisation_id_ref]', back_populates='organisation')
    transfer_ = relationship('Transfer', foreign_keys='[Transfer.source_organisation_id_ref]', back_populates='organisation_')
    vehicle = relationship('Vehicle', back_populates='organisation')
    security_shift = relationship('SecurityShift', back_populates='organisation')


class CareerProfile(Base):
    __tablename__ = 'career_profile'
    __table_args__ = (
        ForeignKeyConstraint(['Profile_domain_id_ref'], ['domain_organisation.idDomain_Organisation'], name='fk_Profile_3'),
        ForeignKeyConstraint(['Profile_position_org'], ['organisation.id_Organisation'], name='fk_Profile_2'),
        ForeignKeyConstraint(['Profile_rank_id_ref'], ['profile_rank.idprofile_rank'], name='fk_Profile_1'),
        ForeignKeyConstraint(['career_profile_availability'], ['availability_state.id_availability_state'], name='fk_career_profile_1'),
        Index('fk_Profile_1_idx', 'Profile_rank_id_ref'),
        Index('fk_Profile_2_idx', 'Profile_position_org'),
        Index('fk_Profile_3_idx', 'Profile_domain_id_ref'),
        Index('fk_career_profile_1_idx', 'career_profile_availability')
    )

    idProfile = Column(Integer, primary_key=True)
    Profile_serial = Column(String(45))
    Profile_rank_id_ref = Column(Integer)
    Profile_position_org = Column(Integer)
    Profile_domain_id_ref = Column(Integer)
    designation_reference = Column(String(45))
    installation_reference = Column(String(45))
    career_profile_availability = Column(Integer)

    domain_organisation = relationship('DomainOrganisation', back_populates='career_profile')
    organisation = relationship('Organisation', back_populates='career_profile')
    profile_rank = relationship('ProfileRank', back_populates='career_profile')
    availability_state = relationship('AvailabilityState', back_populates='career_profile')
    component_community = relationship('ComponentCommunity', back_populates='component_member')
    course = relationship('Course', back_populates='career_profile')
    person = relationship('Person', back_populates='career_profile')
    trainee = relationship('Trainee', back_populates='profile_ref')
    security_shift = relationship('SecurityShift', back_populates='career_profile')


class CommunicationDemand(Base):
    __tablename__ = 'communication_demand'
    __table_args__ = (
        ForeignKeyConstraint(['Communication_demanding_org_ref_id'], ['organisation.id_Organisation'], name='fk_Communication_demand_1'),
        Index('fk_Communication_demand_1_idx', 'Communication_demanding_org_ref_id')
    )

    idCommunication_demand = Column(Integer, primary_key=True)
    Communication_demanding_org_ref_id = Column(Integer)

    Communication_demanding_org_ref = relationship('Organisation', back_populates='communication_demand')
    communication_response = relationship('CommunicationResponse', back_populates='Communication_demand_ref')


class Component(Base):
    __tablename__ = 'component'
    __table_args__ = (
        ForeignKeyConstraint(['component_org'], ['organisation.id_Organisation'], name='fk_component_2'),
        ForeignKeyConstraint(['component_parent'], ['component.id_component'], name='fk_component_1'),
        Index('fk_component_1_idx', 'component_parent'),
        Index('fk_component_2_idx', 'component_org')
    )

    id_component = Column(Integer, primary_key=True)
    component_name_ar = Column(String(255))
    component_name_fr = Column(String(255))
    component_type = Column(String(45))
    component_mission_ar = Column(String(255))
    component_mission_fr = Column(String(255))
    component_parent = Column(Integer)
    component_org = Column(Integer)
    component_ending_date = Column(Date)
    component_starting_date = Column(Date)
    component_head = Column(Integer)
    component_members = Column(Integer)

    organisation = relationship('Organisation', back_populates='component')
    component = relationship('Component', remote_side=[id_component], back_populates='component_reverse')
    component_reverse = relationship('Component', remote_side=[component_parent], back_populates='component')
    component_community = relationship('ComponentCommunity', back_populates='component')
    storable_item = relationship('StorableItem', back_populates='component')
    provision_demand = relationship('ProvisionDemand', foreign_keys='[ProvisionDemand.provision_demand_destination]', back_populates='component')
    provision_demand_ = relationship('ProvisionDemand', foreign_keys='[ProvisionDemand.provision_demand_issuer]', back_populates='component_')


class DocReference(Base):
    __tablename__ = 'doc_reference'
    __table_args__ = (
        ForeignKeyConstraint(['Organisation_id_Organisation'], ['organisation.id_Organisation'], name='fk_doc_reference_Organisation1'),
        Index('fk_doc_reference_Organisation1_idx', 'Organisation_id_Organisation')
    )

    reference_id = Column(Integer, primary_key=True)
    reference_year = Column(Integer)
    reference_ar = Column(String(45))
    reference_fr = Column(String(45))
    Organisation_id_Organisation = Column(Integer)

    organisation = relationship('Organisation', back_populates='doc_reference')
    document = relationship('Document', back_populates='reference')


class Furniture(Base):
    __tablename__ = 'furniture'
    __table_args__ = (
        ForeignKeyConstraint(['furniture_as_equipment_ref'], ['office_equipment.id_office_equipment'], name='fk_furniture_2'),
        ForeignKeyConstraint(['furniture_availability_ref'], ['availability_state.id_availability_state'], name='fk_furniture_5'),
        ForeignKeyConstraint(['furniture_invoice_ref'], ['invoice.id_invoice'], name='fk_furniture_4'),
        ForeignKeyConstraint(['furniture_org_ref'], ['organisation.id_Organisation'], name='fk_furniture_1'),
        ForeignKeyConstraint(['furniture_source'], ['organisation.id_Organisation'], name='fk_furniture_3'),
        Index('fk_furniture_1_idx', 'furniture_org_ref'),
        Index('fk_furniture_2_idx', 'furniture_as_equipment_ref'),
        Index('fk_furniture_3_idx', 'furniture_source'),
        Index('fk_furniture_4_idx', 'furniture_invoice_ref'),
        Index('fk_furniture_5_idx', 'furniture_availability_ref')
    )

    idfurniture = Column(Integer, primary_key=True)
    furniture_as_equipment_ref = Column(Integer)
    furniture_org_ref = Column(Integer)
    furniture_name = Column(String(255))
    furniture_code = Column(String(45))
    furniture_count = Column(Integer)
    furniture_serial = Column(String(45))
    furniture_note = Column(String(45))
    furniture_source = Column(Integer)
    furniture_invoice_ref = Column(Integer)
    furniture_availability_ref = Column(Integer)

    office_equipment = relationship('OfficeEquipment', back_populates='furniture')
    availability_state = relationship('AvailabilityState', back_populates='furniture')
    invoice = relationship('Invoice', back_populates='furniture')
    organisation = relationship('Organisation', foreign_keys=[furniture_org_ref], back_populates='furniture')
    organisation_ = relationship('Organisation', foreign_keys=[furniture_source], back_populates='furniture_')


class Inspection(Base):
    __tablename__ = 'inspection'
    __table_args__ = (
        ForeignKeyConstraint(['insp_org_ref'], ['organisation.id_Organisation'], name='fk_Inspection_1'),
        Index('fk_Inspection_1_idx', 'insp_org_ref')
    )

    id_inspection = Column(Integer, primary_key=True)
    start_date = Column(Date)
    inspection_transcript = Column(LONGTEXT)
    insp_org_ref = Column(Integer)
    end_date = Column(Date)

    organisation = relationship('Organisation', back_populates='inspection')


class MobileEquipment(Base):
    __tablename__ = 'mobile_equipment'
    __table_args__ = (
        ForeignKeyConstraint(['organisation_ref'], ['organisation.id_Organisation'], name='fk_mobile_equipment_1'),
        Index('fk_mobile_equipment_1_idx', 'organisation_ref')
    )

    id_mobile_equipment = Column(Integer, primary_key=True)
    mobile_equipment_desc_ar = Column(String(255))
    mobile_equipment_desc_fr = Column(String(255))
    organisation_ref = Column(Integer)

    organisation = relationship('Organisation', back_populates='mobile_equipment')
    vehicle = relationship('Vehicle', back_populates='mobile_equipment')


class Registry(Base):
    __tablename__ = 'registry'
    __table_args__ = (
        ForeignKeyConstraint(['registry_belonging_org'], ['organisation.id_Organisation'], name='fk_registry_1'),
        Index('fk_registry_1_idx', 'registry_belonging_org')
    )

    id_registry = Column(Integer, primary_key=True)
    registry_designation = Column(String(45))
    registry_purpose = Column(String(45))
    registry_code = Column(String(45))
    registry_belonging_service = Column(String(45))
    registry_belonging_org = Column(Integer)

    organisation = relationship('Organisation', back_populates='registry')


class Review(Base):
    __tablename__ = 'review'
    __table_args__ = (
        ForeignKeyConstraint(['org_ref'], ['organisation.id_Organisation'], name='fk_review_1'),
        Index('fk_review_1_idx', 'org_ref')
    )

    id_review = Column(Integer, primary_key=True)
    review_type = Column(String(45))
    review_reference = Column(String(45))
    org_ref = Column(Integer)

    organisation = relationship('Organisation', back_populates='review')


class Shelf(Base):
    __tablename__ = 'shelf'
    __table_args__ = (
        ForeignKeyConstraint(['cob_ref_id'], ['cob.idCob'], name='fk_Shelf_1'),
        Index('fk_Shelf_1_idx', 'cob_ref_id')
    )

    idShelf = Column(Integer, primary_key=True)
    Shelf_ref_fr = Column(String(45))
    Shelf_ref_ar = Column(String(45))
    cob_ref_id = Column(Integer)

    cob_ref = relationship('Cob', back_populates='shelf')
    container_position = relationship('ContainerPosition', back_populates='Container_position_shelf_ref')


class Transfer(Base):
    __tablename__ = 'transfer'
    __table_args__ = (
        ForeignKeyConstraint(['destination_organisation_id_ref'], ['organisation.id_Organisation'], name='fk_Transfer_2'),
        ForeignKeyConstraint(['source_organisation_id_ref'], ['organisation.id_Organisation'], name='fk_Transfer_1'),
        Index('fk_Transfer_1_idx', 'source_organisation_id_ref'),
        Index('fk_Transfer_2_idx', 'destination_organisation_id_ref'),
        Index('source_organisation_id_ref_UNIQUE', 'source_organisation_id_ref', unique=True)
    )

    idTransfer = Column(Integer, primary_key=True)
    source_organisation_id_ref = Column(Integer)
    destination_organisation_id_ref = Column(Integer)
    container_ref_id = Column(String(45))

    organisation = relationship('Organisation', foreign_keys=[destination_organisation_id_ref], back_populates='transfer')
    organisation_ = relationship('Organisation', foreign_keys=[source_organisation_id_ref], back_populates='transfer_')
    transferred_contained_types = relationship('TransferredContainedTypes', back_populates='transfer')


class CommunicationResponse(Base):
    __tablename__ = 'communication_response'
    __table_args__ = (
        ForeignKeyConstraint(['Communication_demand_ref_id'], ['communication_demand.idCommunication_demand'], name='fk_Communication_response_1'),
        Index('fk_Communication_response_1_idx', 'Communication_demand_ref_id')
    )

    idCommunication_response = Column(Integer, primary_key=True)
    Communication_demand_ref_id = Column(Integer)

    Communication_demand_ref = relationship('CommunicationDemand', back_populates='communication_response')
    communication_subject = relationship('CommunicationSubject', back_populates='Communication_response_ref')


class ComponentCommunity(Base):
    __tablename__ = 'component_community'
    __table_args__ = (
        ForeignKeyConstraint(['component_member_id'], ['career_profile.idProfile'], name='fk_component_community_1'),
        ForeignKeyConstraint(['component_member_in'], ['component.id_component'], name='fk_component_community_2'),
        Index('fk_component_community_1_idx', 'component_member_id'),
        Index('fk_component_community_2_idx', 'component_member_in')
    )

    id_component_membership = Column(Integer, primary_key=True)
    component_member_id = Column(Integer)
    component_member_in = Column(Integer)
    component_membership_activity = Column(String(45))

    component_member = relationship('CareerProfile', back_populates='component_community')
    component = relationship('Component', back_populates='component_community')


class ContainerPosition(Base):
    __tablename__ = 'container_position'
    __table_args__ = (
        ForeignKeyConstraint(['Container_position_cabinet_ref_id'], ['cabinet.idCabinet'], name='fk_Container_position_2'),
        ForeignKeyConstraint(['Container_position_shelf_ref_id'], ['shelf.idShelf'], name='fk_Container_position_1'),
        Index('fk_Container_position_1_idx', 'Container_position_shelf_ref_id'),
        Index('fk_Container_position_2_idx', 'Container_position_cabinet_ref_id')
    )

    idContainer_position = Column(Integer, primary_key=True)
    Container_position_shelf_ref_id = Column(Integer)
    Container_position_cabinet_ref_id = Column(Integer)

    Container_position_cabinet_ref = relationship('Cabinet', back_populates='container_position')
    Container_position_shelf_ref = relationship('Shelf', back_populates='container_position')
    contained_types = relationship('ContainedTypes', back_populates='Container_position_ref')


class Course(Base):
    __tablename__ = 'course'
    __table_args__ = (
        ForeignKeyConstraint(['course_session'], ['session.idsession'], name='fk_course_2'),
        ForeignKeyConstraint(['course_teacher'], ['career_profile.idProfile'], name='fk_course_1'),
        Index('fk_course_1_idx', 'course_teacher'),
        Index('fk_course_2_idx', 'course_session')
    )

    idcourse = Column(Integer, primary_key=True)
    course_teacher = Column(Integer)
    course_title_ar = Column(String(255))
    course_title_fr = Column(String(45))
    course_title_en = Column(String(45))
    course_session = Column(Integer)
    course_start = Column(DateTime)
    course_end = Column(DateTime)

    session = relationship('Session', back_populates='course')
    career_profile = relationship('CareerProfile', back_populates='course')


class Person(Base):
    __tablename__ = 'person'
    __table_args__ = (
        ForeignKeyConstraint(['Person_profile_id_ref'], ['career_profile.idProfile'], name='fk_Person_1'),
        Index('fk_Person_1_idx', 'Person_profile_id_ref')
    )

    PERSON_ID = Column(Integer, primary_key=True)
    Person_name_ar = Column(String(255))
    Person_lastname_ar = Column(String(255))
    Person_profile_id_ref = Column(Integer)
    Person_name_latin = Column(String(255))
    Person_lastname_latin = Column(String(255))

    career_profile = relationship('CareerProfile', back_populates='person')
    app_user = relationship('AppUser', back_populates='person')
    visitor = relationship('Visitor', back_populates='person')


class ReviewedYear(Review):
    __tablename__ = 'reviewed_year'
    __table_args__ = (
        ForeignKeyConstraint(['id_reviewed_year'], ['review.id_review'], name='fk_reviewed_year_1'),
    )

    id_reviewed_year = Column(Integer, primary_key=True)
    reviewed_year = Column(Integer)
    treated_archive_boxes = Column(Integer)
    inventoried_archive_boxes = Column(Integer)
    reviewed_year_note = Column(String(45))
    parent_review_id = Column(Integer)


class StorableItem(Base):
    __tablename__ = 'storable_item'
    __table_args__ = (
        ForeignKeyConstraint(['storable_item_availability_ref'], ['availability_state.id_availability_state'], name='fk_storable_item_3'),
        ForeignKeyConstraint(['storable_item_invoice_ref'], ['invoice.id_invoice'], name='fk_storable_item_2'),
        ForeignKeyConstraint(['storable_item_position'], ['component.id_component'], name='fk_storable_item_1'),
        Index('fk_storable_item_1_idx', 'storable_item_position'),
        Index('fk_storable_item_2_idx', 'storable_item_invoice_ref'),
        Index('fk_storable_item_3_idx', 'storable_item_availability_ref')
    )

    id_storable_item = Column(Integer, primary_key=True)
    storable_item_position = Column(Integer)
    storable_item_quantity = Column(String(45))
    storable_item_last_updated = Column(DateTime)
    storable_item_invoice_ref = Column(Integer)
    storable_item_availability_ref = Column(Integer)

    availability_state = relationship('AvailabilityState', back_populates='storable_item')
    invoice = relationship('Invoice', back_populates='storable_item')
    component = relationship('Component', back_populates='storable_item')
    provision_demand = relationship('ProvisionDemand', back_populates='storable_item')
    security_shift = relationship('SecurityShift', back_populates='storable_item')


class Trainee(Base):
    __tablename__ = 'trainee'
    __table_args__ = (
        ForeignKeyConstraint(['profile_ref_id'], ['career_profile.idProfile'], name='fk_trainee_1'),
        ForeignKeyConstraint(['session_ref_id'], ['session.idsession'], name='fk_trainee_2'),
        Index('fk_trainee_1_idx', 'profile_ref_id'),
        Index('fk_trainee_2_idx', 'session_ref_id')
    )

    idtrainee = Column(Integer, primary_key=True)
    profile_ref_id = Column(Integer)
    session_ref_id = Column(Integer)
    trainee_mark = Column(String(45))
    trainee_evaluation = Column(String(45))

    profile_ref = relationship('CareerProfile', back_populates='trainee')
    session_ref = relationship('Session', back_populates='trainee')


class Vehicle(Base):
    __tablename__ = 'vehicle'
    __table_args__ = (
        ForeignKeyConstraint(['as_mobile_equipment_ref'], ['mobile_equipment.id_mobile_equipment'], name='fk_vehicle_2'),
        ForeignKeyConstraint(['org_ref'], ['organisation.id_Organisation'], name='fk_vehicle_1'),
        ForeignKeyConstraint(['vehicle_invoice_ref'], ['invoice.id_invoice'], name='fk_vehicle_3'),
        ForeignKeyConstraint(['vehicle_state_ref'], ['availability_state.id_availability_state'], name='fk_vehicle_4'),
        Index('fk_vehicle_1_idx', 'org_ref'),
        Index('fk_vehicle_2_idx', 'as_mobile_equipment_ref'),
        Index('fk_vehicle_3_idx', 'vehicle_invoice_ref'),
        Index('fk_vehicle_4_idx', 'vehicle_state_ref')
    )

    id_vehicle = Column(Integer, primary_key=True)
    vehicle_serial = Column(String(255))
    chassis_number = Column(String(45))
    vehicle_name = Column(String(255))
    org_ref = Column(Integer)
    as_mobile_equipment_ref = Column(Integer)
    vehicle_invoice_ref = Column(Integer)
    vehicle_state_ref = Column(Integer)

    mobile_equipment = relationship('MobileEquipment', back_populates='vehicle')
    organisation = relationship('Organisation', back_populates='vehicle')
    invoice = relationship('Invoice', back_populates='vehicle')
    availability_state = relationship('AvailabilityState', back_populates='vehicle')


class AppUser(Base):
    __tablename__ = 'app_user'
    __table_args__ = (
        ForeignKeyConstraint(['Person_ID'], ['person.PERSON_ID'], name='fk_User_Person'),
        Index('fk_User_Person_idx', 'Person_ID')
    )

    USER_ID = Column(Integer, primary_key=True)
    USER_NAME = Column(String(45))
    USER_PASSWORD = Column(String(255))
    Person_ID = Column(Integer)
    admin_privilege = Column(TINYINT)

    person = relationship('Person', back_populates='app_user')
    document = relationship('Document', back_populates='app_user')
    security_shift = relationship('SecurityShift', back_populates='app_user')


class ContainedTypes(Base):
    __tablename__ = 'contained_types'
    __table_args__ = (
        ForeignKeyConstraint(['Container_position_ref_id'], ['container_position.idContainer_position'], name='fk_Contained_types_3'),
        ForeignKeyConstraint(['container_type_ref_id'], ['container.idContainer'], name='fk_Contained_types_1'),
        ForeignKeyConstraint(['types_contained_ref_id'], ['document_type.idDocument_type'], name='fk_Contained_types_2'),
        Index('fk_Contained_types_1_idx', 'container_type_ref_id'),
        Index('fk_Contained_types_2_idx', 'types_contained_ref_id'),
        Index('fk_Contained_types_3_idx', 'Container_position_ref_id')
    )

    idContained_types = Column(Integer, primary_key=True)
    container_type_ref_id = Column(Integer)
    types_contained_ref_id = Column(Integer)
    Container_position_ref_id = Column(Integer)

    Container_position_ref = relationship('ContainerPosition', back_populates='contained_types')
    container_type_ref = relationship('Container', back_populates='contained_types')
    types_contained_ref = relationship('DocumentType', back_populates='contained_types')
    transferred_contained_types = relationship('TransferredContainedTypes', back_populates='contained_types')


class ProvisionDemand(Base):
    __tablename__ = 'provision_demand'
    __table_args__ = (
        ForeignKeyConstraint(['provision_demand_destination'], ['component.id_component'], name='fk_provision_demand_2'),
        ForeignKeyConstraint(['provision_demand_issuer'], ['component.id_component'], name='fk_provision_demand_1'),
        ForeignKeyConstraint(['provision_demand_item'], ['storable_item.id_storable_item'], name='fk_provision_demand_3'),
        Index('fk_provision_demand_1_idx', 'provision_demand_issuer'),
        Index('fk_provision_demand_2_idx', 'provision_demand_destination'),
        Index('fk_provision_demand_3_idx', 'provision_demand_item')
    )

    id_provision_demand = Column(Integer, primary_key=True)
    provision_demand_issuer = Column(Integer)
    provision_demand_destination = Column(Integer)
    provision_demand_item = Column(Integer)
    provision_demand_quantity = Column(String(45))
    provision_demand_datetime = Column(DateTime)
    provision_demand_state = Column(String(255))

    component = relationship('Component', foreign_keys=[provision_demand_destination], back_populates='provision_demand')
    component_ = relationship('Component', foreign_keys=[provision_demand_issuer], back_populates='provision_demand_')
    storable_item = relationship('StorableItem', back_populates='provision_demand')


class Visitor(Base):
    __tablename__ = 'visitor'
    __table_args__ = (
        ForeignKeyConstraint(['visitor_as_person'], ['person.PERSON_ID'], name='fk_visitor_1'),
        Index('fk_visitor_1_idx', 'visitor_as_person')
    )

    id_visitor = Column(Integer, primary_key=True)
    visitor_as_person = Column(Integer)
    visitor_purpose = Column(String(255))
    visitor_entry = Column(DateTime)
    visitor_leave = Column(DateTime)

    person = relationship('Person', back_populates='visitor')


class Document(Base):
    __tablename__ = 'document'
    __table_args__ = (
        ForeignKeyConstraint(['added_by_user_id_ref'], ['app_user.USER_ID'], name='fk_Document_1'),
        ForeignKeyConstraint(['container_ref_id'], ['container.idContainer'], name='fk_Document_User1'),
        ForeignKeyConstraint(['reference_id'], ['doc_reference.reference_id'], name='fk_Document_reference1'),
        Index('Doc_ID_UNIQUE', 'Doc_ID', unique=True),
        Index('fk_Document_1_idx', 'added_by_user_id_ref'),
        Index('fk_Document_User1_idx', 'container_ref_id'),
        Index('fk_Document_reference1_idx', 'reference_id')
    )

    Doc_ID = Column(Integer, primary_key=True, nullable=False)
    reference_id = Column(Integer, primary_key=True, nullable=False)
    Doc_Label = Column(String(255))
    Doc_size = Column(BigInteger)
    USER_ID = Column(Integer)
    container_ref_id = Column(Integer)
    added_by_user_id_ref = Column(Integer)
    document_url = Column(String(255))

    app_user = relationship('AppUser', back_populates='document')
    container_ref = relationship('Container', back_populates='document')
    reference = relationship('DocReference', back_populates='document')
    communication_subject = relationship('CommunicationSubject', back_populates='Communicated_doc_ref')


class SecurityShift(Base):
    __tablename__ = 'security_shift'
    __table_args__ = (
        ForeignKeyConstraint(['security_shift_at'], ['organisation.id_Organisation'], name='fk_security_shift_1'),
        ForeignKeyConstraint(['security_shift_responsible'], ['app_user.USER_ID'], name='fk_security_shift_5'),
        ForeignKeyConstraint(['security_shift_state'], ['availability_state.id_availability_state'], name='fk_security_shift_6'),
        ForeignKeyConstraint(['security_shift_what'], ['storable_item.id_storable_item'], name='fk_security_shift_3'),
        ForeignKeyConstraint(['security_shift_who'], ['career_profile.idProfile'], name='fk_security_shift_2'),
        ForeignKeyConstraint(['shift_position_ref'], ['security_shift_position.id_shift_position'], name='fk_security_shift_4'),
        Index('fk_security_shift_1_idx', 'security_shift_at'),
        Index('fk_security_shift_2_idx', 'security_shift_who'),
        Index('fk_security_shift_3_idx', 'security_shift_what'),
        Index('fk_security_shift_4_idx', 'shift_position_ref'),
        Index('fk_security_shift_5_idx', 'security_shift_responsible'),
        Index('fk_security_shift_6_idx', 'security_shift_state')
    )

    id_security_shift = Column(Integer, primary_key=True)
    shift_position_ref = Column(Integer)
    security_shift_at = Column(Integer)
    security_shift_who = Column(Integer)
    security_shift_what = Column(Integer)
    security_shift_start = Column(DateTime)
    security_shift_end = Column(DateTime)
    security_shift_responsible = Column(Integer)
    security_shift_approved = Column(TINYINT)
    security_shift_state = Column(Integer)

    organisation = relationship('Organisation', back_populates='security_shift')
    app_user = relationship('AppUser', back_populates='security_shift')
    availability_state = relationship('AvailabilityState', back_populates='security_shift')
    storable_item = relationship('StorableItem', back_populates='security_shift')
    career_profile = relationship('CareerProfile', back_populates='security_shift')
    security_shift_position = relationship('SecurityShiftPosition', back_populates='security_shift')


class TransferredContainedTypes(Base):
    __tablename__ = 'transferred_contained_types'
    __table_args__ = (
        ForeignKeyConstraint(['transferred_contained_types_id_ref'], ['transfer.idTransfer'], name='fk_transferred_contained_types_2'),
        ForeignKeyConstraint(['transferred_types_contained'], ['contained_types.idContained_types'], name='fk_transferred_contained_types_1'),
        Index('fk_transferred_contained_types_1_idx', 'transferred_types_contained'),
        Index('fk_transferred_contained_types_2_idx', 'transferred_contained_types_id_ref')
    )

    idtransferred_contained_types = Column(Integer, primary_key=True)
    transferred_contained_types_id_ref = Column(Integer)
    transferred_types_contained = Column(Integer)

    transfer = relationship('Transfer', back_populates='transferred_contained_types')
    contained_types = relationship('ContainedTypes', back_populates='transferred_contained_types')


class CommunicationSubject(Base):
    __tablename__ = 'communication_subject'
    __table_args__ = (
        ForeignKeyConstraint(['Communicated_doc_ref_id'], ['document.Doc_ID'], name='fk_Communication_subject_2'),
        ForeignKeyConstraint(['Communication_response_ref_id'], ['communication_response.idCommunication_response'], name='fk_Communication_subject_1'),
        Index('fk_Communication_subject_1_idx', 'Communication_response_ref_id'),
        Index('fk_Communication_subject_2_idx', 'Communicated_doc_ref_id')
    )

    idCommunication_subject = Column(Integer, primary_key=True)
    Communicated_doc_ref_id = Column(Integer)
    Communication_response_ref_id = Column(Integer)

    Communicated_doc_ref = relationship('Document', back_populates='communication_subject')
    Communication_response_ref = relationship('CommunicationResponse', back_populates='communication_subject')
