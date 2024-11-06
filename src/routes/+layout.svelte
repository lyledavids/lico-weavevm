<script lang="ts">
    import '../app.css';
    import { page } from '$app/stores';
  </script>
  
  <div class="min-h-screen bg-gray-100">
    <nav class="bg-white shadow-md">
      <div class="container mx-auto px-6 py-3">
        <div class="flex justify-between items-center">
          <div class="text-xl font-semibold text-gray-700">
            <a href="/">Lico</a>
          </div>
          <div class="space-x-4">
            <a
              href="/"
              class="text-gray-700 hover:text-blue-500 {$page.url.pathname === '/' ? 'font-bold' : ''}"
            >
              Home
            </a>
            <a
              href="/upload"
              class="text-gray-700 hover:text-blue-500 {$page.url.pathname === '/upload' ? 'font-bold' : ''}"
            >
              Upload
            </a>
            <a
              href="/profile"
              class="text-gray-700 hover:text-blue-500 {$page.url.pathname === '/profile' ? 'font-bold' : ''}"
            >
              Profile
            </a>
          </div>
        </div>
      </div>
    </nav>
  
    <main class="container mx-auto px-6 py-8">
      <slot />
    </main>
  </div>