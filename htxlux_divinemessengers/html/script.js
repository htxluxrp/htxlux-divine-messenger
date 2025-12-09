let isOpen = false;
let closeTimeout = null;

window.addEventListener("message", (event) => {
    const data = event.data;

    if (data.action === "open") {
        const container = document.getElementById("divine-container");
        const msgEl = document.getElementById("divine-message");

        if (!container || !msgEl) return;

        msgEl.textContent = data.message || "";
        container.classList.remove("hidden");
        container.classList.add("showing");
        isOpen = true;

        if (closeTimeout) {
            clearTimeout(closeTimeout);
        }

        // Auto close after 7 seconds (matches vibe of quick whisper)
        closeTimeout = setTimeout(() => {
            container.classList.add("hidden");
            container.classList.remove("showing");
            isOpen = false;

            fetch(`https://${GetParentResourceName()}/htxlux-divine:closed`, {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=UTF-8" },
                body: JSON.stringify({})
            });
        }, 7000);
    }
});
