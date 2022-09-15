from fastapi.routing import APIRouter
from ensembl.production.metadata_api.app.api import echo
from ensembl.production.metadata_api.app.api import docs
from ensembl.production.metadata_api.app.api import info

api_router = APIRouter()
#api_router.include_router(monitoring.router)
api_router.include_router(docs.router)
api_router.include_router(echo.router, prefix="/echo", tags=["echo"])
api_router.include_router(info.router, prefix="/info", tags=["info, metadata"])
