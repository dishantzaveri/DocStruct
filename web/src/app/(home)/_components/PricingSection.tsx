"use client";
import { Divider } from "@nextui-org/divider";
import Aos from "aos";
import { motion, useMotionTemplate, useMotionValue } from "framer-motion";
import { useState, useEffect, type MouseEvent } from "react";
import { Check, X } from "lucide-react";
import { Button } from "@nextui-org/button";
import { Switch } from "@nextui-org/react";

import ActionSectionWrapper from "./hoc";

function PricingSection() {
  const [isSelected, setIsSelected] = useState(true);
  let mouseX = useMotionValue(0);
  let mouseY = useMotionValue(0);
  useEffect(() => {
    Aos.init({ duration: 1000, once: true, easing: "ease", offset: 60 });
  }, []);

  function handleMouseMove({ currentTarget, clientX, clientY }: MouseEvent) {
    let { left, top } = currentTarget.getBoundingClientRect();
    mouseX.set(clientX - left);
    mouseY.set(clientY - top);
  }

  const pricingSectionVariants = [
    {
      title: "Basic Plan",
      GradientColor: "rgb(253, 224, 71, 0.23)",
      price: isSelected ? "₹5000" : "₹45000", // Removed the template literal syntax as it's unnecessary here
      description:
        "Streamline your project's document management with essential features.",
      features: [
        {
          available: true,
          text: "Centralized document storage",
        },
        {
          available: true,
          text: "Intuitive file organization with a clear, accessible sidebar",
        },
        {
          available: false,
          text: "Seamless file access and segmentation",
        },
        {
          available: false,
          text: "Basic version control",
        },
      ],
    },
    {
      title: "Professional Plan",
      GradientColor: "rgb(147, 197, 253, 0.27)",
      price: isSelected ? "₹10000" : "₹90000", // Corrected syntax here as well
      description: "Advanced document management features for larger projects.",
      features: [
        {
          available: true,
          text: "Centralized document storage",
        },
        {
          available: true,
          text: "Enhanced file organization and quick access",
        },
        {
          available: true,
          text: "File segmentation for efficient management",
        },
        {
          available: true,
          text: "Robust version control and comparison",
        },
      ],
    },
    {
      title: "Enterprise Plan",
      GradientColor: "rgb(23, 201, 100, 0.17)",
      price: "Contact us",
      description:
        "Comprehensive solution for enterprise-level document management needs.",
      features: [
        {
          available: true,
          text: "All features in the Professional Plan",
        },
        {
          available: true,
          text: "Cross-platform accessibility for seamless collaboration",
        },
        {
          available: true,
          text: "Advanced interactive tools for document annotation and feedback",
        },
        {
          available: true,
          text: "Customizable access permissions and security settings",
        },
      ],
    },
  ];

  return (
    <>
      <h1
        className="block text-center text-3xl md:text-5xl mt-20"
        data-aos="fade-left"
      >
        Our Subscription Plans
      </h1>

      <div className="flex justify-center mt-6">
        <Switch isSelected={isSelected} onValueChange={setIsSelected}>
          {isSelected ? "Yearly" : "Monthly"}
        </Switch>
      </div>

      <div className="mx-auto lg:max-w-6xl xl:max-w-7xl px-4 sm:px-6 sm:py-6 lg:px-8">
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-3 sm:items-center md:gap-8">
          {pricingSectionVariants.map((variant, index) => (
            <div
              key={index}
              data-aos={`${
                index === 0
                  ? "fade-right"
                  : index === 1
                  ? "fade-up"
                  : "fade-left"
              }`}
              data-aos-delay={index === 1 ? "550" : "650"}
              className={`group relative rounded-2xl border p-6 border-blue-300 sm:px-8 lg:p-8 mt-12 z-30  border-white/10 bg-gray-200  dark:bg-gray-800 px-8 py-16 shadow-2xl
                   ${index !== 1 ? "min-h-[26rem]" : "min-h-[30rem]"} `}
              onMouseMove={handleMouseMove}
            >
              <motion.div
                className="pointer-events-none z-30 absolute -inset-px rounded-xl opacity-0 transition duration-300 group-hover:opacity-100"
                style={{
                  background: useMotionTemplate`
                        radial-gradient(
                          300px circle at ${mouseX}px ${mouseY}px,
                          ${variant.GradientColor},
                          transparent 70%
                        )
                      `,
                }}
                onMouseMove={handleMouseMove}
              />

              <div className="text-center">
                <h2 className="text-lg font-mono">
                  {variant.title}
                  <span className="sr-only">Plan</span>
                </h2>

                <p className="mt-2 sm:mt-4">
                  <strong className="text-3xl font-bold dark:text-stone-400 text-stone-800 sm:text-4xl">
                    {variant.price}
                  </strong>

                  <span className="text-sm font-medium ">/month</span>
                </p>
                <p className="mt-4 text-stone-500">{variant.description}</p>
              </div>

              <Divider className="mt-4" />

              <ul className="mt-6 space-y-2 ">
                {variant.features.map((feature, indexForFeature) => (
                  <li
                    key={indexForFeature}
                    className="flex items-center gap-1 overflow-y-hidden"
                  >
                    {feature.available ? (
                      <Check className="text-success" />
                    ) : (
                      <X className="text-danger" />
                    )}
                    <span className="dark:text-default-500 text-stone-600">
                      {feature.text}
                    </span>
                  </li>
                ))}
              </ul>

              <Button
                variant="shadow"
                color="success"
                fullWidth={index === 1}
                className={`${
                  index === 1
                    ? "mx-auto mt-6 z-50"
                    : "absolute w-[56%] -bottom-5 z-50 left-1/2 transform -translate-x-1/2"
                }`}
              >
                Get Started
              </Button>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}

export default ActionSectionWrapper(PricingSection, "Pricing", 0.5);
