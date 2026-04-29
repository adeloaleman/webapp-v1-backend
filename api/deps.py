import os
from dotenv import load_dotenv
from typing import Annotated

from sqlalchemy.orm import Session
from .database import SessionLocal

from passlib.context import CryptContext
from jose import jwt, JWTError

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer


load_dotenv()
AUTH_SECRET_KEY = os.getenv('AUTH_SECRET_KEY')
AUTH_ALGORITHM = os.getenv('AUTH_ALGORITHM')


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]

bcrypt_context = CryptContext(schemes=['bcrypt'], deprecated='auto')

oauth2_bearer = OAuth2PasswordBearer(tokenUrl='auth/token')
oauth2_bearer_dependency = Annotated[str, Depends(oauth2_bearer)]

async def get_current_user(token:oauth2_bearer_dependency):
    try:
        payload = jwt.decode(token=token, key=AUTH_SECRET_KEY, algorithms=[AUTH_ALGORITHM])
        id:int = payload.get('id')
        username:str = payload.get('username')
        name:str = payload.get('name')
        if id is None or username is None:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Could not validate user')
        return {'id':id, 'username':username, 'name':name}
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail='Could not validate user')
    
user_dependency = Annotated[dict, Depends(get_current_user)] 