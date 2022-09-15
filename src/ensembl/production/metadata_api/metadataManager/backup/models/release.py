from sqlalchemy.sql.schema import Column, ForeignKey
from sqlalchemy.sql.sqltypes import Integer, String, Date, DateTime
from sqlalchemy.orm import relationship

from ensembl.production.metadata_api.metadataManager.base import Base
 


class EnsemblRelease(Base):
    """Model Release Info"""

    __tablename__ = "ensembl_release"

    release_id = Column(Integer(), primary_key=True, autoincrement=True)
    label = Column(String(length=40))  
    version = Column(Integer(10))
    release_date = Column(Date)
    site_id = Column(Integer(),
        ForeignKey("ensembl_site.site_id"),
        nullable=False,
        index=True,
    )
    site_name = relationship("EnsemblSites", back_populates="sites")


class EnsemblSites(Base):
    """Model for demo purpose."""

    __tablename__ = "ensembl_site"

    id = Column(Integer(), primary_key=True, autoincrement=True)
    name = Column(String(length=200))  # noqa: WPS432