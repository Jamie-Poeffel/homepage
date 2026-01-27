<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const mobileMenuOpen = ref(false);
const activeSection = ref('home');

const projects = [
  {
    title: "Git commit message Template Tool",
    description: "Built a commandline tool in Rust for Git commit templates",
    tags: ["Rust"],
    link: "https://github.com/Jamie-Poeffel/gito",
    image: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
  },
  {
    title: "TicTacToe",
    description: "Offline TicTacToe game built in C#",
    tags: ["C#"],
    link: "https://github.com/Jamie-Poeffel/TicTacToe",
    image: "M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6"
  },
  {
    title: "Parkour Baar",
    description: "Website for a parkour association built with Next.js",
    tags: ["React", "Next.js", "TypeScript"],
    link: "https://github.com/Jamie-Poeffel/Parkour-Baar",
    image: "M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364"
  }
];

const skills = [
  { name: "JavaScript", level: 95, color: "from-indigo-500 to-indigo-400" },
  { name: "TypeScript", level: 90, color: "from-indigo-500 to-indigo-400" },
  { name: "React", level: 92, color: "from-slate-500 to-slate-400" },
  { name: "Vue.js", level: 88, color: "from-slate-500 to-slate-400" },
  { name: "Node.js", level: 85, color: "from-slate-600 to-slate-500" },
  { name: "Python", level: 80, color: "from-slate-600 to-slate-500" },
  { name: "PostgreSQL", level: 75, color: "from-slate-700 to-slate-600" },
  { name: "MongoDB", level: 70, color: "from-slate-700 to-slate-600" },
  { name: "Docker", level: 72, color: "from-slate-600 to-slate-500" },
  { name: "Rust", level: 35, color: "from-slate-700 to-slate-600" }
];

const experiences = [
  {
    year: "2023 – Present",
    role: "IMS Student",
    company: "FMZ Luzern",
    description: "Computer science education with focus on backend development, APIs, and software architecture."
  }
];

let observers = [];

onMounted(() => {
  setupScrollAnimations();
  window.addEventListener('scroll', handleScroll);
  window.addEventListener('scroll', handleParallax);
  animateSkillBars();
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
  window.removeEventListener('scroll', handleParallax);
  observers.forEach(o => o.disconnect());
});

function setupScrollAnimations() {
  const fadeObserver = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('animate-fade-in');
        e.target.classList.remove('opacity-0');
      }
    });
  }, { threshold: 0.1 });

  const slideObserver = new IntersectionObserver(entries => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('animate-slide-up');
        e.target.classList.remove('opacity-0', 'translate-y-8');
      }
    });
  }, { threshold: 0.1 });

  document.querySelectorAll('.fade-in').forEach(el => fadeObserver.observe(el));
  document.querySelectorAll('.slide-up').forEach(el => slideObserver.observe(el));

  observers = [fadeObserver, slideObserver];
}

function handleScroll() {
  const sections = ['home','about','skills','projects','experience','contact'];
  const pos = window.scrollY + 120;

  for (const s of sections) {
    const el = document.getElementById(s);
    if (el && pos >= el.offsetTop && pos < el.offsetTop + el.offsetHeight) {
      activeSection.value = s;
      break;
    }
  }
}

function handleParallax() {
  const el = document.querySelector('.parallax-bg');
  if (el) el.style.transform = `translateY(${window.pageYOffset * 0.3}px)`;
}

function animateSkillBars() {
  document.querySelectorAll('.skill-bar').forEach((bar, i) => {
    setTimeout(() => {
      const skill = skills.find(s => s.name === bar.dataset.skill);
      if (skill) bar.style.width = skill.level + '%';
    }, i * 120);
  });
}

function scrollToSection(id) {
  const el = document.getElementById(id);
  if (!el) return;
  window.scrollTo({ top: el.offsetTop - 80, behavior: 'smooth' });
  mobileMenuOpen.value = false;
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 overflow-x-hidden">

    <!-- BACKGROUND PARTICLES -->
    <div class="fixed inset-0 parallax-bg pointer-events-none">
      <div
        v-for="i in 20"
        :key="i"
        class="absolute w-1 h-1 bg-slate-500 rounded-full animate-pulse opacity-20"
        :style="{ left: `${Math.random()*100}%`, top: `${Math.random()*100}%` }"
      />
    </div>

    <!-- NAV -->
    <nav class="fixed w-full bg-slate-900/90 backdrop-blur border-b border-slate-700 z-50">
      <div class="max-w-7xl mx-auto px-6 h-16 flex justify-between items-center">
        <button
          @click="scrollToSection('home')"
          class="text-xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-slate-200">
          Jamie
        </button>

        <div class="hidden md:flex gap-8">
          <button
            v-for="s in ['about','skills','projects','experience','contact']"
            :key="s"
            @click="scrollToSection(s)"
            :class="activeSection===s ? 'text-indigo-400' : 'text-gray-400 hover:text-indigo-400'">
            {{ s.charAt(0).toUpperCase()+s.slice(1) }}
          </button>
        </div>
      </div>
    </nav>

    <!-- HERO -->
    <section id="home" class="min-h-screen pt-32 flex items-center justify-center text-center">
      <div class="fade-in opacity-0">
        <h1 class="text-6xl font-bold mb-6 text-white">
          Hi, I'm
          <span class="text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-slate-200">
            Jamie
          </span>
        </h1>
        <p class="text-gray-400 max-w-xl mx-auto mb-10">
          Full Stack Developer with a strong backend focus.
        </p>
        <button
          @click="scrollToSection('projects')"
          class="px-8 py-3 bg-indigo-600 hover:bg-indigo-500 rounded-full transition">
          View Projects
        </button>
      </div>
    </section>

    <!-- ABOUT -->
    <section id="about" class="py-20 max-w-4xl mx-auto text-center fade-in opacity-0">
      <h2 class="text-4xl font-bold mb-6 text-white">About Me</h2>
      <p class="text-gray-400 leading-relaxed">
        IMS student passionate about backend development, clean code, and scalable systems.
      </p>
    </section>

    <!-- SKILLS -->
    <section id="skills" class="py-20 max-w-4xl mx-auto">
      <h2 class="text-4xl font-bold mb-10 text-center text-white slide-up opacity-0 translate-y-8">Skills</h2>
      <div v-for="skill in skills" :key="skill.name" class="mb-4 fade-in opacity-0">
        <div class="flex justify-between mb-1 text-sm text-gray-300">
          <span>{{ skill.name }}</span>
          <span>{{ skill.level }}%</span>
        </div>
        <div class="h-3 bg-slate-800 rounded-full">
          <div
            class="skill-bar h-full rounded-full bg-gradient-to-r transition-all duration-1000"
            :class="skill.color"
            :data-skill="skill.name"
            style="width:0%">
          </div>
        </div>
      </div>
    </section>

    <!-- PROJECTS -->
    <section id="projects" class="py-20 max-w-7xl mx-auto">
      <h2 class="text-4xl font-bold mb-12 text-center text-white slide-up opacity-0 translate-y-8">
        Projects
      </h2>
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        <a
          v-for="p in projects"
          :key="p.title"
          :href="p.link"
          target="_blank"
          class="bg-slate-800/60 border border-slate-700 rounded-xl p-6 hover:border-slate-500 transition fade-in opacity-0">
          <h3 class="text-lg font-semibold text-indigo-400 mb-2">{{ p.title }}</h3>
          <p class="text-gray-400 mb-4 text-sm">{{ p.description }}</p>
          <div class="flex gap-2 flex-wrap">
            <span v-for="t in p.tags" :key="t" class="text-xs px-3 py-1 rounded-full bg-slate-700 text-slate-300">
              {{ t }}
            </span>
          </div>
        </a>
      </div>
    </section>

    <!-- EXPERIENCE -->
    <section id="experience" class="py-20 max-w-4xl mx-auto fade-in opacity-0">
      <h2 class="text-4xl font-bold mb-10 text-center text-white">Experience</h2>
      <div
        v-for="e in experiences"
        :key="e.year"
        class="bg-slate-800/60 border border-slate-700 rounded-xl p-6">
        <div class="text-indigo-400 font-semibold">{{ e.year }}</div>
        <h3 class="font-bold text-white">{{ e.role }}</h3>
        <div class="text-gray-400 mb-2">{{ e.company }}</div>
        <p class="text-gray-300">{{ e.description }}</p>
      </div>
    </section>

    <!-- CONTACT -->
    <section id="contact" class="py-20 max-w-3xl mx-auto text-center fade-in opacity-0">
      <h2 class="text-4xl font-bold mb-6 text-white">Contact</h2>
      <p class="text-gray-400 mb-8">Open for projects and collaboration.</p>
      <a
        href="mailto:jamie@example.com"
        class="inline-block px-8 py-3 bg-indigo-600 hover:bg-indigo-500 rounded-full transition">
        Send Email
      </a>
    </section>

    <!-- FOOTER -->
    <footer class="py-8 text-center text-gray-500 border-t border-slate-700 fade-in opacity-0">
      © 2026 Jamie — Built with Vue.js
    </footer>
  </div>
</template>

<style scoped>
/* ===============================
   Custom animations
================================ */

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes float {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-10px);
  }
}

@keyframes gradient {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

/* ===============================
   Animation utility classes
================================ */

.animate-fade-in {
  animation: fadeIn 0.8s ease-out forwards;
}

.animate-slide-up {
  animation: slideUp 0.8s ease-out forwards;
}

.animate-slide-down {
  animation: slideDown 0.3s ease-out forwards;
}

.animate-float {
  animation: float 3s ease-in-out infinite;
}

.animate-gradient {
  background-size: 200% 200%;
  animation: gradient 4s ease infinite;
}

/* ===============================
   Global behavior
================================ */

/* Smooth scrolling */
html {
  scroll-behavior: smooth;
}

/* ===============================
   Scrollbar (muted, no neon)
================================ */

::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: rgba(30, 41, 59, 0.6); /* slate-800 */
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(
    to bottom,
    #6366f1, /* indigo-500 */
    #94a3b8  /* slate-400 */
  );
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(
    to bottom,
    #4f46e5, /* indigo-600 */
    #64748b  /* slate-500 */
  );
}
</style>