const API_BASE_URL = 'http://localhost:5000';

const responseOutput = document.getElementById('response-output');
const accessTokenField = document.getElementById('access-token');
const refreshTokenField = document.getElementById('refresh-token');

const storage = {
  get accessToken() {
    return localStorage.getItem('accessToken') || '';
  },
  get refreshToken() {
    return localStorage.getItem('refreshToken') || '';
  },
  setTokens(accessToken, refreshToken) {
    if (accessToken) {
      localStorage.setItem('accessToken', accessToken);
    }

    if (refreshToken) {
      localStorage.setItem('refreshToken', refreshToken);
    }

    renderTokens();
  },
  clear() {
    localStorage.removeItem('accessToken');
    localStorage.removeItem('refreshToken');
    renderTokens();
  }
};

function renderTokens() {
  accessTokenField.value = storage.accessToken;
  refreshTokenField.value = storage.refreshToken;
}

function showResponse(payload) {
  responseOutput.textContent = JSON.stringify(payload, null, 2);
}

async function apiRequest(path, options = {}) {
  const headers = {
    'Content-Type': 'application/json',
    ...(options.headers || {})
  };

  if (storage.accessToken && !headers.Authorization && options.auth !== false) {
    headers.Authorization = `Bearer ${storage.accessToken}`;
  }

  const response = await fetch(`${API_BASE_URL}${path}`, {
    ...options,
    headers
  });

  const data = await response.json().catch(() => ({}));

  if (!response.ok) {
    throw { status: response.status, data };
  }

  return data;
}

function normalizeTokens(data) {
  return {
    accessToken: data?.data?.accessToken || data?.accessToken || '',
    refreshToken: data?.data?.token || data?.token || data?.refreshToken || ''
  };
}

async function handleSubmit(path, event) {
  event.preventDefault();
  const formData = new FormData(event.currentTarget);
  const body = Object.fromEntries(formData.entries());

  try {
    const data = await apiRequest(path, {
      method: 'POST',
      auth: false,
      body: JSON.stringify(body)
    });
    const tokens = normalizeTokens(data);
    storage.setTokens(tokens.accessToken, tokens.refreshToken);
    showResponse(data);
  } catch (error) {
    showResponse(error);
  }
}

document.getElementById('register-form').addEventListener('submit', (event) => {
  handleSubmit('/auth/register', event);
});

document.getElementById('login-form').addEventListener('submit', (event) => {
  handleSubmit('/auth/login', event);
});

document.getElementById('me-btn').addEventListener('click', async () => {
  try {
    const data = await apiRequest('/auth/me');
    showResponse(data);
  } catch (error) {
    showResponse(error);
  }
});

document.getElementById('refresh-btn').addEventListener('click', async () => {
  try {
    const data = await apiRequest('/auth/refresh', {
      method: 'POST',
      auth: false,
      body: JSON.stringify({ refreshToken: storage.refreshToken })
    });
    const tokens = normalizeTokens(data);
    storage.setTokens(tokens.accessToken || storage.accessToken, tokens.refreshToken || storage.refreshToken);
    showResponse(data);
  } catch (error) {
    showResponse(error);
  }
});

document.getElementById('logout-btn').addEventListener('click', async () => {
  try {
    const data = await apiRequest('/auth/logout', {
      method: 'POST',
      auth: false,
      body: JSON.stringify({ refreshToken: storage.refreshToken })
    });
    storage.clear();
    showResponse(data);
  } catch (error) {
    showResponse(error);
  }
});

renderTokens();
