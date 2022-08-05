from fastapi.security import OAuth2PasswordBearer


"""
# API & HTTPS Parameters
"""
API_IP = "127.0.0.1"
API_PORT = 8000 
KEY_FILE = "config/key.pem"
CERT_FILE = "config/cert.pem"


"""
# Database Parameters
"""
DB_USER = 'root' 
DB_PASS = 'root' 
DB_IP = 'viewcast_db' 
DB_PORT = '3306'

CREATE_DB_URL = f'mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_IP}:{DB_PORT}/'
DB_URL = f"mysql://{DB_USER}:{DB_PASS}@{DB_IP}:{DB_PORT}/viewcast"
MODEL_PATHS = ['database.models.models']


"""
# JWT Parameters
"""
ALGORITHM = "RS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 10
PRIV_KEY = open('config/priv_key.pem', 'r').read()
PUB_KEY = open('config/pub_key.pub', 'r').read()


"""
# CORS & Middleware Parameters
"""
ALLOWED_HOSTS = ["127.0.0.1", "localhost", API_IP]
ALLOWED_METHODS = ["GET", "PUT", "POST", "DELETE"]
ORIGINS = [
    "*",
]


"""
# Regex Policies
"""
PASSWORD_POLICY = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{12,}$'
EMAIL_POLICY = r'^.+\@.+\..+$'
PHONE_POLICY = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'


"""
# OAuth2 Initialisation, Permissions
"""
OAUTH2_SCHEME = OAuth2PasswordBearer(
    tokenUrl="token",
    scopes={"user": "Token for personal access",
            "admin": "Token for admin access"
            }
)
