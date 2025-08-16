// Import Turbo and Stimulus
import "@hotwired/turbo-rails"
import "controllers"

// Use turbo:load event instead of DOMContentLoaded for better Turbo compatibility
document.addEventListener('turbo:load', function() {
  // Handle Enter key for adding quests
  const questInputs = document.querySelectorAll('.add-quest-input');
  
  questInputs.forEach(input => {
    input.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        const form = this.closest('form');
        const submitBtn = form.querySelector('.add-btn');
        
        // Add loading state
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
        
        form.submit();
      }
    });
  });

  // Add loading states to form submissions
  const addButtons = document.querySelectorAll('.add-btn');
  addButtons.forEach(btn => {
    btn.addEventListener('click', function() {
      this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
    });
  });

  // Add smooth animations for quest items
  const questItems = document.querySelectorAll('.quest-item');
  questItems.forEach((item, index) => {
    item.style.animationDelay = `${index * 0.1}s`;
  });

  // Focus on input when page loads
  const firstInput = document.querySelector('.add-quest-input');
  if (firstInput) {
    setTimeout(() => firstInput.focus(), 100);
  }

  // Add keyboard shortcuts
  document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + K to focus on input
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
      e.preventDefault();
      const input = document.querySelector('.add-quest-input');
      if (input) {
        input.focus();
        input.select();
      }
    }
  });

  // Auto-expand textarea functionality (if needed)
  const textInputs = document.querySelectorAll('.add-quest-input');
  textInputs.forEach(input => {
    input.addEventListener('input', function() {
      // Remove extra spaces
      this.value = this.value.replace(/\s+/g, ' ');
    });
  });
});