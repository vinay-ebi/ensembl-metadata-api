from pydantic import BaseModel


class MetadataInfo(BaseModel):
    """
    Return Current Release Metadata Info

    """

    label: str
    version: int
    release_date: str
    ensembl_site : list  

#     class Config:
#         orm_mode = True


# class DummyModelInputDTO(BaseModel):
#     """DTO for creating new dummy model."""

#     name: str




