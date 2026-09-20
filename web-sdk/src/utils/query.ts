export type QueryPrimitive = string | number | boolean | null | undefined;
export type QueryValue = QueryPrimitive;

export function buildQueryString(query: Record<string, QueryValue>): string {
  const searchParams = new URLSearchParams();

  for (const [key, value] of Object.entries(query)) {
    if (value == null || value === '') {
      continue;
    }

    searchParams.set(key, String(value));
  }

  return searchParams.toString();
}

export function joinUrl(baseUrl: string, path: string): string {
  const normalizedPath = path.startsWith('/') ? path : `/${path}`;
  return `${baseUrl}${normalizedPath}`;
}

