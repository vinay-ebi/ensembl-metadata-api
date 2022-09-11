from fastapi.routing import APIRouter
from ensembl.production.metadata_api.app.api import echo
from ensembl.production.metadata_api.app.api import docs

#from ensembl-metadata-api.web.api import dummy
#from ensembl-metadata-api.web.api import rabbit
#from ensembl-metadata-api.web.api import monitoring

api_router = APIRouter()
#api_router.include_router(monitoring.router)
api_router.include_router(docs.router)
api_router.include_router(echo.router, prefix="/echo", tags=["echo"])
#api_router.include_router(dummy.router, prefix="/dummy", tags=["dummy"])
