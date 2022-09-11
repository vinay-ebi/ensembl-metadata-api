import uvicorn
import os
import shutil
import logging
from importlib import metadata
from pathlib import Path

from fastapi import FastAPI
from fastapi.responses import UJSONResponse
from fastapi.staticfiles import StaticFiles



from ensembl.production.metadata_api.app.settings import settings
from ensembl.production.metadata_api.app.api.router import api_router
#from ensembl.production.metadata-api.database.db_startupevent_lifetime import register_startup_event, register_shutdown_event

APP_ROOT = Path(__file__).parent.parent


def get_app() -> FastAPI:
    """
    Get FastAPI application.

    This is the main constructor of an application.

    :return: application.
    """
    app = FastAPI(
        title="ensembl-metadata-api",
        description="New metadata service to support 2020 metadata database",
        version=metadata.version("metadata-api"),
        docs_url=None,
        redoc_url=None,
        
        openapi_url="/api/openapi.json",
        default_response_class=UJSONResponse,
    )

    # Adds startup and shutdown events.
    #register_startup_event(app)
    #register_shutdown_event(app)

    # Main router for the API.
    app.include_router(router=api_router, prefix="/api")
    # Adds static directory.
    # This directory is used to access swagger files.
    app.mount(
        "/static",
        StaticFiles(directory=APP_ROOT / "static"),
        name="static"
    )

    return app

def main() -> None:
    """Entrypoint of the application."""
    uvicorn.run(
        get_app, #"ensembl-metadata-api.web.application:get_app",
        workers=settings.workers_count,
        host=settings.host,
        port=settings.port,
        reload=settings.reload,
        log_level=settings.log_level.value.lower(),
        factory=True,
    )


if __name__ == "__main__":
    main()