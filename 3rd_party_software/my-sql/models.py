# coding: utf-8
from sqlalchemy import BigInteger, Column, Date, ForeignKey, Integer, LargeBinary, SmallInteger, String
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.mysql import TINYINT
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class Container(Base):
    __tablename__ = 'Container'

    idContainer = Column(Integer, primary_key=True)
    type_container = Column(String(45))


class DocumentType(Base):
    __tablename__ = 'Document_type'

    idDocument_type = Column(Integer, primary_key=True)
    document_type_label_fr = Column(String(45))
    document_type_label_ar = Column(String(45))


class DomainOrganisation(Base):
    __tablename__ = 'Domain_Organisation'

    idDomain_Organisation = Column(Integer, primary_key=True)
    Domain_Organisation_label_fr = Column(String(45))
    Domain_Organisation_label_ar = Column(String(45))
    Domain_Organisation_acronym_fr = Column(String(45))
    Domain_Organisation_acronym_ar = Column(String(45))


class Region(Base):
    __tablename__ = 'Region'

    idRegion = Column(Integer, primary_key=True)
    region_label_fr = Column(String(45))
    region_label_ar = Column(String(45))
    region_acronym_fr = Column(String(45))
    region_acronym_ar = Column(String(45))


class Store(Base):
    __tablename__ = 'Store'

    idStore = Column(Integer, primary_key=True)
    Storetype = Column(String(45))
    store_label_fr = Column(String(45))
    store_label_ar = Column(String(45))
    store_acronym_fr = Column(String(45))
    store_acronym_ar = Column(String(45))


class Transcript(Base):
    __tablename__ = 'Transcript'

    idTranscript = Column(Integer, primary_key=True)
    reference_transcript = Column(String(45))


class ProfileRank(Base):
    __tablename__ = 'profile_rank'

    idprofile_rank = Column(Integer, primary_key=True)
    profile_rank_label_fr = Column(String(45))
    profile_rank_label_ar = Column(String(45))
    profile_rank_acronym_fr = Column(String(45))
    profile_rank_acronym_ar = Column(String(45))


class Session(Base):
    __tablename__ = 'session'

    idsession = Column(Integer, primary_key=True)
    session_start_date = Column(Date)
    session_end_date = Column(Date)


class Bay(Base):
    __tablename__ = 'Bay'

    idBay = Column(Integer, primary_key=True)
    Bay_number = Column(ForeignKey('Store.idStore'), index=True)

    Store = relationship('Store')


class Cabinet(Base):
    __tablename__ = 'Cabinet'

    idCabinet = Column(Integer, primary_key=True)
    Cabinet_store_ref_id = Column(ForeignKey('Store.idStore'), index=True)

    Cabinet_store_ref = relationship('Store')


class Elimination(Base):
    __tablename__ = 'Elimination'

    idElimination = Column(Integer, primary_key=True, nullable=False)
    max_eliminated_date = Column(Date)
    min_eliminated_date = Column(Date)
    id_transcript = Column(ForeignKey('Transcript.idTranscript'), primary_key=True, nullable=False, index=True)
    doc_type_ref = Column(ForeignKey('Document_type.idDocument_type'), primary_key=True, nullable=False, index=True)
    elimination_container_ref_id = Column(ForeignKey('Container.idContainer'), nullable=False, index=True)

    Document_type = relationship('DocumentType')
    elimination_container_ref = relationship('Container')
    Transcript = relationship('Transcript')


class Sector(Base):
    __tablename__ = 'Sector'

    idSector = Column(Integer, primary_key=True)
    label_sector_fr = Column(String(45))
    label_sector_ar = Column(String(45))
    acronym_sector_fr = Column(String(45))
    acronym_sector_ar = Column(String(45))
    region_ref_id = Column(ForeignKey('Region.idRegion'), index=True)

    region_ref = relationship('Region')


class DocumentTypeBelonging(Base):
    __tablename__ = 'document_type_belongings'

    iddocument_type_belongings = Column(Integer, primary_key=True)
    belonging_domain_id_ref = Column(ForeignKey('Domain_Organisation.idDomain_Organisation'), index=True)
    belonging_type_id_ref = Column(ForeignKey('Document_type.idDocument_type'), index=True)
    belonging_code = Column(String(45))

    Domain_Organisation = relationship('DomainOrganisation')
    Document_type = relationship('DocumentType')


class Cob(Base):
    __tablename__ = 'Cob'

    idCob = Column(Integer, primary_key=True)
    Cob_id_ref = Column(ForeignKey('Bay.idBay'), index=True)

    Bay = relationship('Bay')


class Organisation(Base):
    __tablename__ = 'Organisation'

    id_Organisation = Column(Integer, primary_key=True)
    Organisation_name_ar = Column(String(255))
    Organisation_name_fr = Column(String(255))
    ACRONYM_AR = Column(String(45))
    ACRONYM_FR = Column(String(45))
    Organisation_domain_id_ref = Column(ForeignKey('Domain_Organisation.idDomain_Organisation'), index=True)
    sector_ref_id = Column(ForeignKey('Sector.idSector'), index=True)

    Domain_Organisation = relationship('DomainOrganisation')
    sector_ref = relationship('Sector')


class CommunicationDemand(Base):
    __tablename__ = 'Communication_demand'

    idCommunication_demand = Column(Integer, primary_key=True)
    Communication_demanding_org_ref_id = Column(ForeignKey('Organisation.id_Organisation'), index=True)

    Communication_demanding_org_ref = relationship('Organisation')


class Profile(Base):
    __tablename__ = 'Profile'

    idProfile = Column(Integer, primary_key=True)
    Profile_serial = Column(String(45))
    Profile_rank_id_ref = Column(ForeignKey('profile_rank.idprofile_rank'), index=True)
    Profile_position_org = Column(ForeignKey('Organisation.id_Organisation'), index=True)
    Profile_domain_id_ref = Column(ForeignKey('Domain_Organisation.idDomain_Organisation'), index=True)

    Domain_Organisation = relationship('DomainOrganisation')
    Organisation = relationship('Organisation')
    profile_rank = relationship('ProfileRank')


class Shelf(Base):
    __tablename__ = 'Shelf'

    idShelf = Column(Integer, primary_key=True)
    Shelf_id_ref = Column(ForeignKey('Cob.idCob'), index=True)

    Cob = relationship('Cob')


class Transfer(Base):
    __tablename__ = 'Transfer'

    idTransfer = Column(Integer, primary_key=True)
    source_organisation_id_ref = Column(ForeignKey('Organisation.id_Organisation'), index=True)
    destination_organisation_id_ref = Column(ForeignKey('Organisation.id_Organisation'), index=True)
    container_ref_id = Column(String(45))

    Organisation = relationship('Organisation', primaryjoin='Transfer.destination_organisation_id_ref == Organisation.id_Organisation')
    Organisation1 = relationship('Organisation', primaryjoin='Transfer.source_organisation_id_ref == Organisation.id_Organisation')


class DocReference(Base):
    __tablename__ = 'doc_reference'

    reference_id = Column(Integer, primary_key=True)
    reference_year = Column(Integer)
    reference_ar = Column(String(45))
    reference_fr = Column(String(45))
    Organisation_id_Organisation = Column(ForeignKey('Organisation.id_Organisation'), index=True)

    Organisation = relationship('Organisation')


class CommunicationResponse(Base):
    __tablename__ = 'Communication_response'

    idCommunication_response = Column(Integer, primary_key=True)
    Communication_demand_ref_id = Column(ForeignKey('Communication_demand.idCommunication_demand'), index=True)

    Communication_demand_ref = relationship('CommunicationDemand')


class ContainerPosition(Base):
    __tablename__ = 'Container_position'

    idContainer_position = Column(Integer, primary_key=True)
    Container_position_shelf_ref_id = Column(ForeignKey('Shelf.idShelf'), index=True)
    Container_position_cabinet_ref_id = Column(ForeignKey('Cabinet.idCabinet'), index=True)

    Container_position_cabinet_ref = relationship('Cabinet')
    Container_position_shelf_ref = relationship('Shelf')


class Person(Base):
    __tablename__ = 'Person'

    PERSON_ID = Column(Integer, primary_key=True)
    Person_name = Column(String(45))
    Person_lastname = Column(String(45))
    Person_profile_id_ref = Column(ForeignKey('Profile.idProfile'), index=True)

    Profile = relationship('Profile')


class Trainee(Base):
    __tablename__ = 'trainee'

    idtrainee = Column(Integer, primary_key=True)
    profile_ref_id = Column(ForeignKey('Profile.idProfile'), index=True)
    session_ref_id = Column(ForeignKey('session.idsession'), index=True)
    trainee_mark = Column(String(45))
    trainee_evaluation = Column(String(45))

    profile_ref = relationship('Profile')
    session_ref = relationship('Session')


class ContainedType(Base):
    __tablename__ = 'Contained_types'

    idContained_types = Column(Integer, primary_key=True)
    container_type_ref_id = Column(ForeignKey('Container.idContainer'), index=True)
    types_contained_ref_id = Column(ForeignKey('Document_type.idDocument_type'), index=True)
    Container_position_ref_id = Column(ForeignKey('Container_position.idContainer_position'), index=True)

    Container_position_ref = relationship('ContainerPosition')
    container_type_ref = relationship('Container')
    types_contained_ref = relationship('DocumentType')


class User(Base):
    __tablename__ = 'User'

    USER_ID = Column(Integer, primary_key=True)
    USER_NAME = Column(String(45))
    USER_PASSWORD = Column(String(255))
    Person_ID = Column(ForeignKey('Person.PERSON_ID'), index=True)
    admin_privilege = Column(TINYINT)

    Person = relationship('Person')


class Document(Base):
    __tablename__ = 'Document'

    Doc_ID = Column(Integer, primary_key=True, nullable=False)
    Doc_Label = Column(String(255))
    Doc_size = Column(BigInteger)
    Doc_number_of_chunks = Column(SmallInteger)
    reference_id = Column(ForeignKey('doc_reference.reference_id'), primary_key=True, nullable=False, index=True)
    USER_ID = Column(Integer)
    Doc_chunk_number = Column(SmallInteger)
    container_ref_id = Column(ForeignKey('Container.idContainer'), index=True)
    added_by_user_id_ref = Column(ForeignKey('User.USER_ID'), index=True)

    User = relationship('User')
    container_ref = relationship('Container')
    reference = relationship('DocReference')


class TransferredContainedType(Base):
    __tablename__ = 'transferred_contained_types'

    idtransferred_contained_types = Column(Integer, primary_key=True)
    transferred_contained_types_id_ref = Column(ForeignKey('Transfer.idTransfer'), index=True)
    transferred_types_contained = Column(ForeignKey('Contained_types.idContained_types'), index=True)

    Transfer = relationship('Transfer')
    Contained_type = relationship('ContainedType')


class CommunicationSubject(Base):
    __tablename__ = 'Communication_subject'

    idCommunication_subject = Column(Integer, primary_key=True)
    Communicated_doc_ref_id = Column(ForeignKey('Document.Doc_ID'), index=True)
    Communication_response_ref_id = Column(ForeignKey('Communication_response.idCommunication_response'), index=True)

    Communicated_doc_ref = relationship('Document')
    Communication_response_ref = relationship('CommunicationResponse')


class DocumentChunk(Base):
    __tablename__ = 'Document_chunk'

    idChunk = Column(Integer, primary_key=True, nullable=False)
    Document_Doc_ID = Column(ForeignKey('Document.Doc_ID'), primary_key=True, nullable=False, index=True)
    Document_chunk_data = Column(LargeBinary)

    Document = relationship('Document')
