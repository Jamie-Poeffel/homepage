<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const mobileMenuOpen = ref(false);
const activeSection = ref('home');

const projects = [
  {
    title: "E-Commerce Platform",
    description: "Built a full-stack e-commerce solution with React, Node.js, and PostgreSQL",
    tags: ["React", "Node.js", "PostgreSQL"],
    link: "#",
    image: "M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
  },
  {
    title: "AI Analytics Dashboard",
    description: "Real-time analytics platform with machine learning predictions",
    tags: ["Vue.js", "Python", "TensorFlow", "D3.js"],
    link: "#",
    image: "M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
  },
  {
    title: "Mobile Fitness App",
    description: "Cross-platform fitness tracking app with social features",
    tags: ["React Native", "Firebase", "GraphQL", "AWS"],
    link: "#",
    image: "M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
  },
];

const skills = [
  { name: "JavaScript", level: 95, color: "from-yellow-400 to-yellow-600" },
  { name: "TypeScript", level: 90, color: "from-blue-400 to-blue-600" },
  { name: "React", level: 92, color: "from-cyan-400 to-cyan-600" },
  { name: "Vue.js", level: 88, color: "from-green-400 to-green-600" },
  { name: "Node.js", level: 85, color: "from-green-500 to-green-700" },
  { name: "Python", level: 80, color: "from-blue-500 to-blue-700" },
  { name: "PostgreSQL", level: 75, color: "from-blue-600 to-blue-800" },
  { name: "MongoDB", level: 70, color: "from-green-600 to-green-800" },
  { name: "AWS", level: 78, color: "from-orange-400 to-orange-600" },
  { name: "Docker", level: 72, color: "from-blue-400 to-cyan-500" },
];

const experiences = [
  {
    year: "2023 - Present",
    role: "Senior Full Stack Developer",
    company: "Tech Innovations Inc.",
    description: "Leading development of cloud-native applications and mentoring junior developers"
  },
  {
    year: "2021 - 2023",
    role: "Frontend Developer",
    company: "Digital Solutions LLC",
    description: "Built responsive web applications and collaborated with UX/UI designers"
  },
  {
    year: "2019 - 2021",
    role: "Junior Developer",
    company: "StartUp Ventures",
    description: "Developed and maintained client websites and web applications"
  }
];

// Animation observers
let observers = [];

onMounted(() => {
  // Initialize scroll animations
  setupScrollAnimations();

  // Handle scroll for active section detection
  window.addEventListener('scroll', handleScroll);

  // Parallax effect for hero section
  window.addEventListener('scroll', handleParallax);

  // Animate skill bars after component is mounted
  animateSkillBars();
});

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll);
  window.removeEventListener('scroll', handleParallax);
  observers.forEach(observer => observer.disconnect());
});

function setupScrollAnimations() {
  // Create Intersection Observer for fade-in animations
  const fadeObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-fade-in');
        entry.target.classList.remove('opacity-0');
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });

  // Create Intersection Observer for slide animations
  const slideObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-slide-up');
        entry.target.classList.remove('opacity-0', 'translate-y-8');
      }
    });
  }, { threshold: 0.1 });

  // Observe all elements with animation classes
  document.querySelectorAll('.fade-in').forEach(el => fadeObserver.observe(el));
  document.querySelectorAll('.slide-up').forEach(el => slideObserver.observe(el));

  observers = [fadeObserver, slideObserver];
}

function handleScroll() {
  // Update active section based on scroll position
  const sections = ['home', 'about', 'skills', 'projects', 'experience', 'contact'];
  const scrollPosition = window.scrollY + 100;

  for (const section of sections) {
    const element = document.getElementById(section);
    if (element) {
      const offsetTop = element.offsetTop;
      const offsetBottom = offsetTop + element.offsetHeight;

      if (scrollPosition >= offsetTop && scrollPosition < offsetBottom) {
        activeSection.value = section;
        break;
      }
    }
  }
}

function handleParallax() {
  const scrolled = window.pageYOffset;
  const parallax = document.querySelector('.parallax-bg');
  if (parallax) {
    parallax.style.transform = `translateY(${scrolled * 0.5}px)`;
  }
}

function animateSkillBars() {
  // Get all skill bar elements
  const skillBarElements = document.querySelectorAll('.skill-bar');

  skillBarElements.forEach((bar, index) => {
    setTimeout(() => {
      const skill = skills.find(s => s.name === bar.dataset.skill);
      if (skill) {
        bar.style.width = skill.level + '%';
      }
    }, 100 + index * 100);
  });
}

// Smooth scroll to section
function scrollToSection(sectionId) {
  const element = document.getElementById(sectionId);
  if (element) {
    window.scrollTo({
      top: element.offsetTop - 80,
      behavior: 'smooth'
    });
    mobileMenuOpen.value = false;
  }
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 overflow-x-hidden">
    <!-- Animated background particles -->
    <div class="fixed inset-0 overflow-hidden parallax-bg">
      <div v-for="i in 30" :key="i" class="absolute w-1 h-1 bg-purple-400 rounded-full animate-pulse" :style="{
        left: `${Math.random() * 100}%`,
        top: `${Math.random() * 100}%`,
        animationDelay: `${Math.random() * 5}s`,
        opacity: Math.random() * 0.3 + 0.1
      }">
      </div>
      <div v-for="i in 15" :key="'star-' + i" class="absolute w-0.5 h-0.5 bg-white rounded-full" :style="{
        left: `${Math.random() * 100}%`,
        top: `${Math.random() * 100}%`,
        opacity: Math.random() * 0.5 + 0.2
      }">
      </div>
    </div>

    <!-- Navigation -->
    <nav class="fixed w-full bg-slate-900/80 backdrop-blur-md z-50 border-b border-purple-500/20">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <button @click="scrollToSection('home')"
            class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400 hover:from-purple-300 hover:to-pink-300 transition-all duration-300 transform hover:scale-105">
            Jamie
          </button>

          <!-- Desktop Menu -->
          <div class="hidden md:flex space-x-8">
            <button v-for="section in ['about', 'skills',  'experience','projects', 'contact']" :key="section"
              @click="scrollToSection(section)" :class="[
                'relative py-2 text-sm font-medium transition-all duration-300',
                activeSection === section
                  ? 'text-purple-400'
                  : 'text-gray-300 hover:text-purple-400'
              ]">
              {{ section.charAt(0).toUpperCase() + section.slice(1) }}
              <span v-if="activeSection === section"
                class="absolute bottom-0 left-0 w-full h-0.5 bg-gradient-to-r from-purple-400 to-pink-400 animate-pulse"></span>
            </button>
          </div>

          <!-- Mobile Menu Button -->
          <button class="md:hidden text-gray-300 hover:text-purple-400 transition-colors"
            @click="mobileMenuOpen = !mobileMenuOpen">
            <svg v-if="mobileMenuOpen" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
              fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="3" y1="12" x2="21" y2="12"></line>
              <line x1="3" y1="6" x2="21" y2="6"></line>
              <line x1="3" y1="18" x2="21" y2="18"></line>
            </svg>
          </button>
        </div>

        <!-- Mobile Menu -->
        <div v-if="mobileMenuOpen" class="md:hidden pb-4 animate-slide-down">
          <button v-for="section in ['about', 'skills' ,'experience', 'projects', 'contact']" :key="'mobile-' + section"
            @click="scrollToSection(section)"
            class="block w-full text-left py-3 text-gray-300 hover:text-purple-400 hover:bg-purple-500/10 px-4 rounded-lg transition-colors">
            {{ section.charAt(0).toUpperCase() + section.slice(1) }}
          </button>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="min-h-screen pt-32 pb-20 px-4 sm:px-6 lg:px-8 flex items-center">
      <div class="max-w-7xl mx-auto text-center fade-in opacity-0">
        <div class="mb-8 inline-block">
          <div
            class="w-32 h-32 mx-auto mb-6 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 p-1 animate-float">
            <div class="w-full h-full rounded-full bg-slate-900 flex items-center justify-center">
              <span
                class="text-4xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">J</span>
            </div>
          </div>
        </div>

        <h1 class="text-5xl sm:text-7xl font-bold text-white mb-6 slide-up opacity-0 translate-y-8">
          Hi, I'm <span
            class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400 animate-gradient">Jamie</span>
        </h1>
        <p class="text-xl sm:text-2xl text-gray-300 mb-8 fade-in opacity-0" style="animation-delay: 0.2s">
          Full Stack Developer & <span class="text-purple-400">Creative Problem Solver</span>
        </p>
        <p class="text-lg text-gray-400 max-w-3xl mx-auto mb-12 fade-in opacity-0" style="animation-delay: 0.4s">
          I build exceptional digital experiences that are fast, accessible, visually appealing, and responsive.
          Let's bring your ideas to life!
        </p>
        <div class="flex flex-col sm:flex-row justify-center gap-4 fade-in opacity-0" style="animation-delay: 0.6s">
          <button @click="scrollToSection('contact')"
            class="px-8 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white rounded-full font-semibold hover:shadow-lg hover:shadow-purple-500/50 transition-all duration-300 transform hover:-translate-y-1 active:scale-95">
            Get In Touch
          </button>
          <button @click="scrollToSection('projects')"
            class="px-8 py-3 border-2 border-purple-400 text-purple-400 rounded-full font-semibold hover:bg-purple-400/10 transition-all duration-300 transform hover:-translate-y-1 active:scale-95">
            View Work
          </button>
        </div>

        <!-- Scroll indicator -->
        <div class="mt-20 fade-in opacity-0" style="animation-delay: 1s">
          <button @click="scrollToSection('about')"
            class="animate-bounce text-gray-400 hover:text-purple-400 transition-colors">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 mx-auto" fill="none" viewBox="0 0 24 24"
              stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
            </svg>
          </button>
        </div>
      </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-20 px-4 sm:px-6 lg:px-8 bg-slate-900/30 relative">
      <div class="max-w-7xl mx-auto">
        <h2 class="text-4xl font-bold text-white mb-12 text-center slide-up opacity-0 translate-y-8">
          About <span class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Me</span>
        </h2>
        <div class="grid md:grid-cols-2 gap-12 items-center">
          <div class="fade-in opacity-0">
            <div class="relative">
              <div class="w-full h-96 rounded-2xl bg-gradient-to-br from-purple-500/20 to-pink-500/20 p-1">
                <div
                  class="w-full h-full rounded-2xl bg-slate-900/80 backdrop-blur-sm p-8 flex flex-col justify-center">
                  <h3 class="text-2xl font-bold text-white mb-4">Passionate Developer</h3>
                  <p class="text-gray-300 mb-6">
                    With over 5 years of experience in web development, I specialize in creating
                    seamless digital experiences that blend creativity with technical excellence.
                  </p>
                  <div class="grid grid-cols-2 gap-4">
                    <div class="text-center p-4 bg-slate-800/50 rounded-lg">
                      <div class="text-3xl font-bold text-purple-400">50+</div>
                      <div class="text-gray-400">Projects</div>
                    </div>
                    <div class="text-center p-4 bg-slate-800/50 rounded-lg">
                      <div class="text-3xl font-bold text-purple-400">30+</div>
                      <div class="text-gray-400">Clients</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="fade-in opacity-0" style="animation-delay: 0.3s">
            <p class="text-lg text-gray-300 leading-relaxed mb-6">
              I'm a passionate full stack developer with a love for creating elegant solutions to complex problems.
              With experience in modern web technologies, I specialize in building responsive, user-friendly
              applications
              that make a difference.
            </p>
            <p class="text-lg text-gray-300 leading-relaxed mb-6">
              My approach combines technical expertise with creative problem-solving to deliver high-quality
              solutions that exceed expectations. I believe in writing clean, maintainable code and staying
              up-to-date with the latest industry trends.
            </p>
            <p class="text-lg text-gray-300 leading-relaxed">
              When I'm not coding, you can find me exploring new technologies, contributing to
              open source, or sharing knowledge with the developer community.
            </p>
          </div>
        </div>
      </div>
    </section>

    <!-- Skills Section -->
    <section id="skills" class="py-20 px-4 sm:px-6 lg:px-8 relative">
      <div class="max-w-7xl mx-auto">
        <h2 class="text-4xl font-bold text-white mb-12 text-center slide-up opacity-0 translate-y-8">
          My <span class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Skills</span>
        </h2>

        <div class="grid md:grid-cols-2 gap-12 mb-16">
          <div v-for="(skill, index) in skills.slice(0, 5)" :key="skill.name" class="fade-in opacity-0"
            :style="`animation-delay: ${index * 0.1}s`">
            <div class="flex justify-between items-center mb-2">
              <span class="text-gray-300 font-medium">{{ skill.name }}</span>
              <span class="text-purple-400 font-bold">{{ skill.level }}%</span>
            </div>
            <div class="h-3 bg-slate-800 rounded-full overflow-hidden">
              <div
                :class="`skill-bar h-full rounded-full bg-gradient-to-r ${skill.color} transition-all duration-1000 ease-out`"
                :data-skill="skill.name" :style="{ width: '0%' }">
              </div>
            </div>
          </div>
        </div>

        <div class="flex flex-wrap gap-3 justify-center fade-in opacity-0" style="animation-delay: 0.6s">
          <span v-for="(skill) in skills.slice(5)" :key="'tag-' + skill.name"
            class="px-6 py-3 bg-purple-500/20 border border-purple-500/30 text-purple-300 rounded-full font-medium hover:bg-purple-500/30 transition-all duration-300 transform hover:-translate-y-1 hover:shadow-lg hover:shadow-purple-500/20">
            {{ skill.name }}
          </span>
        </div>
      </div>
    </section>

    <!-- Experience Section -->
    <section id="experience" class="py-20 px-4 sm:px-6 lg:px-8 bg-slate-900/30">
      <div class="max-w-4xl mx-auto">
        <h2 class="text-4xl font-bold text-white mb-12 text-center slide-up opacity-0 translate-y-8">
          Work <span
            class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Experience</span>
        </h2>

        <div class="relative">
          <!-- Timeline line -->
          <div
            class="absolute left-1/2 transform -translate-x-1/2 h-full w-0.5 bg-gradient-to-b from-purple-500 to-pink-500">
          </div>

          <!-- Timeline items -->
          <div v-for="(exp, index) in experiences" :key="exp.year" :class="[
            'relative mb-12 fade-in opacity-0',
            index % 2 === 0 ? 'md:ml-auto md:pl-12 md:pr-0 md:text-left' : 'md:mr-auto md:pr-12 md:pl-0 md:text-right'
          ]" :style="`animation-delay: ${index * 0.2}s`">
            <div class="md:w-1/2 pl-8 md:pl-0">
              <div
                class="bg-slate-800/50 border border-purple-500/20 rounded-lg p-6 hover:border-purple-500/50 transition-all duration-300 transform hover:-translate-y-1">
                <div
                  class="absolute -left-4 md:left-1/2 transform md:-translate-x-1/2 w-8 h-8 rounded-full bg-gradient-to-r from-purple-500 to-pink-500 flex items-center justify-center">
                  <div class="w-3 h-3 rounded-full bg-slate-900"></div>
                </div>
                <div class="text-purple-400 font-bold mb-2">{{ exp.year }}</div>
                <h3 class="text-xl font-bold text-white mb-2">{{ exp.role }}</h3>
                <div class="text-gray-400 mb-3">{{ exp.company }}</div>
                <p class="text-gray-300">{{ exp.description }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Projects Section -->
    <section id="projects" class="py-20 px-4 sm:px-6 lg:px-8 relative">
      <div class="max-w-7xl mx-auto">
        <h2 class="text-4xl font-bold text-white mb-12 text-center slide-up opacity-0 translate-y-8">
          Featured <span
            class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Projects</span>
        </h2>
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="(project, index) in projects" :key="index"
            class="bg-slate-800/50 border border-purple-500/20 rounded-lg p-6 hover:border-purple-500/50 transition-all duration-300 transform hover:-translate-y-2 group fade-in opacity-0"
            :style="`animation-delay: ${index * 0.2}s`">
            <div class="mb-4 p-4 bg-gradient-to-br from-purple-900/30 to-pink-900/30 rounded-lg">
              <svg class="w-12 h-12 text-purple-400 mx-auto" xmlns="http://www.w3.org/2000/svg" fill="none"
                viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" :d="project.image" />
              </svg>
            </div>
            <div class="flex justify-between items-start mb-4">
              <h3 class="text-xl font-bold text-white group-hover:text-purple-400 transition-colors">{{ project.title }}
              </h3>
              <svg
                class="text-gray-400 group-hover:text-purple-400 transition-colors transform group-hover:translate-x-1 group-hover:-translate-y-1"
                xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                <polyline points="15 3 21 3 21 9"></polyline>
                <line x1="10" y1="14" x2="21" y2="3"></line>
              </svg>
            </div>
            <p class="text-gray-300 mb-4">{{ project.description }}</p>
            <div class="flex flex-wrap gap-2">
              <span v-for="(tag, tagIndex) in project.tags" :key="tagIndex"
                class="px-3 py-1 bg-purple-500/20 text-purple-300 text-sm rounded-full hover:bg-purple-500/30 transition-colors">
                {{ tag }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-20 px-4 sm:px-6 lg:px-8 bg-slate-900/30">
      <div class="max-w-4xl mx-auto text-center fade-in opacity-0">
        <h2 class="text-4xl font-bold text-white mb-8">Let's <span
            class="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Connect</span></h2>
        <p class="text-lg text-gray-300 mb-12 max-w-2xl mx-auto">
          I'm always open to discussing new opportunities, creative projects, or just having a friendly chat about
          technology.
        </p>

        <div class="bg-slate-800/50 border border-purple-500/20 rounded-2xl p-8 md:p-12 mb-12">
          <h3 class="text-2xl font-bold text-white mb-6">Send me a message</h3>
          <form class="space-y-6 text-left">
            <div class="grid md:grid-cols-2 gap-6">
              <div>
                <label class="block text-gray-300 mb-2">Name</label>
                <input type="text"
                  class="w-full bg-slate-900/50 border border-purple-500/30 rounded-lg px-4 py-3 text-white focus:outline-none focus:border-purple-500 transition-colors"
                  placeholder="Your name">
              </div>
              <div>
                <label class="block text-gray-300 mb-2">Email</label>
                <input type="email"
                  class="w-full bg-slate-900/50 border border-purple-500/30 rounded-lg px-4 py-3 text-white focus:outline-none focus:border-purple-500 transition-colors"
                  placeholder="your@email.com">
              </div>
            </div>
            <div>
              <label class="block text-gray-300 mb-2">Message</label>
              <textarea rows="4"
                class="w-full bg-slate-900/50 border border-purple-500/30 rounded-lg px-4 py-3 text-white focus:outline-none focus:border-purple-500 transition-colors"
                placeholder="Your message..."></textarea>
            </div>
            <button type="submit"
              class="w-full md:w-auto px-8 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white rounded-full font-semibold hover:shadow-lg hover:shadow-purple-500/50 transition-all duration-300 transform hover:-translate-y-1 active:scale-95">
              Send Message
            </button>
          </form>
        </div>

        <div class="flex justify-center gap-6">
          <a href="mailto:jamie@example.com"
            class="p-4 bg-purple-500/20 border border-purple-500/30 rounded-full text-purple-300 hover:bg-purple-500/30 hover:scale-110 transition-all duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="2" y="4" width="20" height="16" rx="2"></rect>
              <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
            </svg>
          </a>
          <a href="https://github.com"
            class="p-4 bg-purple-500/20 border border-purple-500/30 rounded-full text-purple-300 hover:bg-purple-500/30 hover:scale-110 transition-all duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path
                d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4">
              </path>
              <path d="M9 18c-4.51 2-5-2-7-2"></path>
            </svg>
          </a>
          <a href="https://linkedin.com"
            class="p-4 bg-purple-500/20 border border-purple-500/30 rounded-full text-purple-300 hover:bg-purple-500/30 hover:scale-110 transition-all duration-300">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path>
              <rect x="2" y="9" width="4" height="12"></rect>
              <circle cx="4" cy="4" r="2"></circle>
            </svg>
          </a>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="py-8 px-4 border-t border-purple-500/20 text-center text-gray-400 fade-in opacity-0">
      <p>© 2026 Jamie. Made using Vue.js</p>
    </footer>
  </div>
</template>

<style scoped>
/* Custom animations */
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

  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-10px);
  }
}

@keyframes gradient {

  0%,
  100% {
    background-position: 0% 50%;
  }

  50% {
    background-position: 100% 50%;
  }
}

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
  animation: gradient 3s ease infinite;
}

/* Smooth scrolling */
html {
  scroll-behavior: smooth;
}

/* Hide scrollbar for Chrome, Safari and Opera */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: rgba(30, 41, 59, 0.5);
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(to bottom, #8b5cf6, #ec4899);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(to bottom, #7c3aed, #db2777);
}
</style>
