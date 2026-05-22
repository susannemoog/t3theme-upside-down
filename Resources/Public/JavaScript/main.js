(() => {
  const root = document.documentElement;
  const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // ─── Header scroll state ───
  const header = document.querySelector('.ud-header');
  if (header) {
    const onScroll = () => {
      header.classList.toggle('is-scrolled', window.scrollY > 60);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  // ─── Intersection Observer: fade-in on scroll ───
  if (root && !reducedMotion) {
    const targets = document.querySelectorAll(
      '.ud-content, .ud-storybeat, .ud-section-header, .ud-featured__card, .ud-section-label, .ud-character-card, .ud-location-card'
    );
    if (targets.length) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (!entry.isIntersecting) {
              return;
            }

            entry.target.animate(
              [
                { opacity: 0, transform: 'translateY(16px)' },
                { opacity: 1, transform: 'translateY(0)' }
              ],
              {
                duration: 520,
                easing: 'cubic-bezier(0.2, 0.7, 0.2, 1)',
                fill: 'both'
              }
            );

            observer.unobserve(entry.target);
          });
        },
        {
          threshold: 0.15,
          rootMargin: '0px 0px -40px 0px'
        }
      );

      targets.forEach((target) => observer.observe(target));
    }
  }

  // ─── Ash / Spore Particle System ───
  if (!reducedMotion) {
    const canvas = document.createElement('canvas');
    canvas.style.cssText = [
      'position:fixed',
      'inset:0',
      'z-index:0',
      'pointer-events:none',
      'width:100%',
      'height:100%'
    ].join(';');
    document.body.prepend(canvas);

    const ctx = canvas.getContext('2d');
    const PARTICLE_COUNT = 700;
    const COLORS = [
      [45, 191, 176],   // teal signal
      [196, 28, 53],    // blood red
      [141, 168, 188],  // muted blue-grey
    ];

    let particles = [];
    let animId;

    function resize() {
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    }

    function randomParticle(canvas) {
      const color = COLORS[Math.floor(Math.random() * COLORS.length)];
      return {
        x: Math.random() * canvas.width,
        y: canvas.height + Math.random() * 80,
        r: 0.8 + Math.random() * 2.2,
        opacity: 0.06 + Math.random() * 0.16,
        vx: (Math.random() - 0.5) * 0.35,
        vy: -(0.18 + Math.random() * 0.42),
        color,
        life: 0,
        maxLife: 220 + Math.random() * 340,
      };
    }

    function initParticles() {
      resize();
      particles = Array.from({ length: PARTICLE_COUNT }, () => {
        const p = randomParticle(canvas);
        p.y = Math.random() * canvas.height;
        p.life = Math.random() * p.maxLife;
        return p;
      });
    }

    function tick() {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      for (let i = 0; i < particles.length; i++) {
        const p = particles[i];
        p.x += p.vx;
        p.y += p.vy;
        p.life++;

        const progress = p.life / p.maxLife;
        const fadeIn = Math.min(progress * 6, 1);
        const fadeOut = progress > 0.75 ? 1 - (progress - 0.75) / 0.25 : 1;
        const alpha = p.opacity * fadeIn * fadeOut;

        ctx.beginPath();
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(${p.color[0]},${p.color[1]},${p.color[2]},${alpha})`;
        ctx.fill();

        if (p.life >= p.maxLife || p.y < -10) {
          particles[i] = randomParticle(canvas);
        }
      }

      animId = requestAnimationFrame(tick);
    }

    initParticles();
    tick();

    window.addEventListener('resize', () => {
      cancelAnimationFrame(animId);
      initParticles();
      tick();
    }, { passive: true });
  }

  // ─── Brand Title Glitch Effect ───
  if (!reducedMotion) {
    const brandTitle = document.querySelector('.ud-brand__title');
    if (brandTitle) {
      function triggerGlitch() {
        brandTitle.classList.add('ud-flicker');
        brandTitle.addEventListener('animationend', () => {
          brandTitle.classList.remove('ud-flicker');
        }, { once: true });

        // Schedule next glitch at random 10–20s interval
        setTimeout(triggerGlitch, 10000 + Math.random() * 10000);
      }

      // First glitch after 5s
      setTimeout(triggerGlitch, 5000);
    }
  }

  // ─── Testimonial Slider Controls ───
  const sliders = document.querySelectorAll('.ud-slider');
  sliders.forEach((slider) => {
    const track = slider.querySelector('.ud-slider__track');
    const prevBtn = slider.querySelector('.ud-slider__btn--prev');
    const nextBtn = slider.querySelector('.ud-slider__btn--next');

    if (!track) return;

    function getItemWidth() {
      const firstItem = track.querySelector('.ud-slider__item');
      if (!firstItem) return 300;
      const style = window.getComputedStyle(track);
      const gap = parseFloat(style.gap) || 16;
      return firstItem.offsetWidth + gap;
    }

    function updateButtons() {
      if (prevBtn) {
        prevBtn.disabled = track.scrollLeft <= 1;
      }
      if (nextBtn) {
        const atEnd = track.scrollLeft + track.clientWidth >= track.scrollWidth - 1;
        nextBtn.disabled = atEnd;
      }
    }

    if (prevBtn) {
      prevBtn.addEventListener('click', () => {
        track.scrollBy({ left: -getItemWidth(), behavior: 'smooth' });
      });
    }

    if (nextBtn) {
      nextBtn.addEventListener('click', () => {
        track.scrollBy({ left: getItemWidth(), behavior: 'smooth' });
      });
    }

    track.addEventListener('scroll', updateButtons, { passive: true });
    updateButtons();
  });
})();
